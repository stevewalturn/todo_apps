import 'package:stacked/stacked_annotations.dart';
import 'package:todo_apps/services/storage_service.dart';

class TodoService implements InitializableDependency {
  final StorageService _storageService;

  TodoService(this._storageService);

  @override
  Future<void> init() async {}

  Future<List<Map<String, dynamic>>> getTodos() async {
    try {
      final todos = _storageService.getTodos();
      return todos ?? [];
    } catch (e) {
      throw Exception('Failed to load todos: Please try again later');
    }
  }

  Future<void> addTodo(String title, String description) async {
    try {
      if (title.isEmpty) {
        throw Exception('Todo title cannot be empty');
      }

      final todos = await getTodos();
      final newTodo = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'title': title,
        'description': description,
        'completed': false,
        'createdAt': DateTime.now().toIso8601String(),
      };

      todos.add(newTodo);
      await _storageService.saveTodos(todos);
    } catch (e) {
      throw Exception('Failed to add todo: ${e.toString()}');
    }
  }

  Future<void> updateTodo(String id,
      {String? title, String? description, bool? completed}) async {
    try {
      final todos = await getTodos();
      final index = todos.indexWhere((todo) => todo['id'] == id);

      if (index == -1) {
        throw Exception('Todo not found');
      }

      if (title != null && title.isEmpty) {
        throw Exception('Todo title cannot be empty');
      }

      todos[index] = {
        ...todos[index],
        if (title != null) 'title': title,
        if (description != null) 'description': description,
        if (completed != null) 'completed': completed,
      };

      await _storageService.saveTodos(todos);
    } catch (e) {
      throw Exception('Failed to update todo: ${e.toString()}');
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      final todos = await getTodos();
      final filtered = todos.where((todo) => todo['id'] != id).toList();
      await _storageService.saveTodos(filtered);
    } catch (e) {
      throw Exception('Failed to delete todo: Please try again later');
    }
  }

  Future<void> toggleTodoComplete(String id) async {
    try {
      final todos = await getTodos();
      final index = todos.indexWhere((todo) => todo['id'] == id);

      if (index == -1) {
        throw Exception('Todo not found');
      }

      todos[index] = {
        ...todos[index],
        'completed': !(todos[index]['completed'] as bool),
      };

      await _storageService.saveTodos(todos);
    } catch (e) {
      throw Exception('Failed to update todo status: Please try again later');
    }
  }
}
