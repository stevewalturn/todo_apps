import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_apps/app/app.locator.dart';
import 'package:todo_apps/features/todo/todo_repository.dart';

class TodoViewModel extends BaseViewModel {
  final _todoRepository = locator<TodoRepository>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  List<Map<String, dynamic>> _todos = [];
  List<Map<String, dynamic>> get todos => _todos;

  Future<void> loadTodos() async {
    try {
      setBusy(true);
      _todos = await _todoRepository.getTodos();
      notifyListeners();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<void> addTodo(String title, String description) async {
    try {
      setBusy(true);
      await _todoRepository.addTodo(title, description);
      await loadTodos();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<void> toggleTodoComplete(String id) async {
    try {
      await _todoRepository.toggleTodoComplete(id);
      await loadTodos();
    } catch (e) {
      setError(e.toString());
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      final response = await _dialogService.showDialog(
        title: 'Delete Todo',
        description: 'Are you sure you want to delete this todo?',
        buttonTitle: 'Delete',
        cancelTitle: 'Cancel',
      );

      if (response?.confirmed ?? false) {
        setBusy(true);
        await _todoRepository.deleteTodo(id);
        await loadTodos();
      }
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  void navigateToProfile() {
    _navigationService.navigateToProfileView();
  }

  void init() {
    loadTodos();
  }
}
