import 'package:todo_apps/app/app.locator.dart';
import 'package:todo_apps/services/todo_service.dart';

class TodoRepository {
  final _todoService = locator<TodoService>();

  TodoRepository();

  Future<List<Map<String, dynamic>>> getTodos() async {
    try {
      return await _todoService.getTodos();
    } catch (e) {
      throw Exception('Failed to load todos: ${e.toString()}');
    }
  }

  Future<void> addTodo(String title, String description) async {
    try {
      await _todoService.addTodo(title, description);
    } catch (e) {
      throw Exception('Failed to add todo: ${e.toString()}');
    }
  }

  Future<void> updateTodo(String id,
      {String? title, String? description, bool? completed}) async {
    try {
      await _todoService.updateTodo(
        id,
        title: title,
        description: description,
        completed: completed,
      );
    } catch (e) {
      throw Exception('Failed to update todo: ${e.toString()}');
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      await _todoService.deleteTodo(id);
    } catch (e) {
      throw Exception('Failed to delete todo: ${e.toString()}');
    }
  }

  Future<void> toggleTodoComplete(String id) async {
    try {
      await _todoService.toggleTodoComplete(id);
    } catch (e) {
      throw Exception('Failed to toggle todo status: ${e.toString()}');
    }
  }
}
