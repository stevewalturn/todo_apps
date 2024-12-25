import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked_annotations.dart';

class StorageService implements InitializableDependency {
  static const String _userKey = 'user_data';
  static const String _tokenKey = 'auth_token';
  static const String _todosKey = 'todos_data';

  late SharedPreferences _prefs;

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveData(String key, dynamic value) async {
    if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else if (value is List<String>) {
      await _prefs.setStringList(key, value);
    } else {
      await _prefs.setString(key, json.encode(value));
    }
  }

  T? getData<T>(String key) {
    final value = _prefs.get(key);
    if (value == null) return null;

    if (T == String) {
      return value as T;
    } else if (T == bool) {
      return value as T;
    } else if (T == int) {
      return value as T;
    } else if (T == double) {
      return value as T;
    } else if (T == List<String>) {
      return value as T;
    } else {
      try {
        return json.decode(value as String) as T;
      } catch (e) {
        return null;
      }
    }
  }

  Future<void> removeData(String key) async {
    await _prefs.remove(key);
  }

  Future<void> clearAll() async {
    await _prefs.clear();
  }

  // Auth specific methods
  Future<void> saveToken(String token) async {
    await saveData(_tokenKey, token);
  }

  String? getToken() {
    return getData<String>(_tokenKey);
  }

  Future<void> removeToken() async {
    await removeData(_tokenKey);
  }

  // User specific methods
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    await saveData(_userKey, userData);
  }

  Map<String, dynamic>? getUserData() {
    return getData<Map<String, dynamic>>(_userKey);
  }

  Future<void> removeUserData() async {
    await removeData(_userKey);
  }

  // Todos specific methods
  Future<void> saveTodos(List<Map<String, dynamic>> todos) async {
    await saveData(_todosKey, todos);
  }

  List<Map<String, dynamic>>? getTodos() {
    final data = getData<List<dynamic>>(_todosKey);
    if (data == null) return null;
    return data.cast<Map<String, dynamic>>();
  }

  Future<void> removeTodos() async {
    await removeData(_todosKey);
  }
}
