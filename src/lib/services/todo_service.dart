import 'package:injectable/injectable.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:todo_apps/app/app.locator.dart';
import 'package:todo_apps/services/storage_service.dart';

@lazySingleton
class TodoService implements InitializableDependency {
  final _storageService = locator<StorageService>();

  @override
  Future<void> init() async {}

  Future<List<Map<String, dynamic>>> getTodos() async {
    try {
      final todos = _storageService.getTodos();
      return todos ?? [];
    } catch (e) {
      throw Exception('Failed to load todos');
    }
  }

  Future<void> addTodo(String title, String description) async {
    try {
      final todos = await getTodos();
      todos.add({
        'id': DateTime.now().toString(),
        'title': title,
        'description': description,
        'completed': false,
      });
      await _storageService.saveTodos(todos);
    } catch (e) {
      throw Exception('Failed to add todo');
    }
  }

  Future<void> updateTodo(String id, {
    String? title,
    String? description,
    bool? completed,
  }) async {
    try {
      final todos = await getTodos();
      final index = todos.indexWhere((todo) => todo['id'] == id);
      if (index != -1) {
        todos[index] = {
          ...todos[index],
          if (title != null) 'title': title,
          if (description != null) 'description': description,
          if (completed != null) 'completed': completed,
        };
        await _storageService.saveTodos(todos);
      }
    } catch (e) {
      throw Exception('Failed to update todo');
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      final todos = await getTodos();
      todos.removeWhere((todo) => todo['id'] == id);
      await _storageService.saveTodos(todos);
    } catch (e) {
      throw Exception('Failed to delete todo');
    }
  }

  Future<void> toggleTodoComplete(String id) async {
    try {
      final todos = await getTodos();
      final index = todos.indexWhere((todo) => todo['id'] == id);
      if (index != -1) {
        final currentTodo = todos[index];
        await updateTodo(
          id,
          completed: !(currentTodo['completed'] as bool),
        );
      }
    } catch (e) {
      throw Exception('Failed to toggle todo status');
    }
  }
}