import 'package:stacked/stacked_annotations.dart';
import 'package:todo_apps/models/user.dart';
import 'package:todo_apps/services/storage_service.dart';

class AuthService implements InitializableDependency {
  final StorageService _storageService;
  User? _currentUser;

  AuthService(this._storageService);

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;

  @override
  Future<void> init() async {
    await _loadUserFromStorage();
  }

  Future<void> _loadUserFromStorage() async {
    final userData = _storageService.getUserData();
    if (userData != null) {
      _currentUser = User.fromJson(userData);
    }
  }

  Future<void> login(String email, String password) async {
    try {
      // Simulate API call with validation
      if (email.isEmpty || password.isEmpty) {
        throw Exception('Email and password are required');
      }

      if (!email.contains('@')) {
        throw Exception('Please enter a valid email address');
      }

      if (password.length < 6) {
        throw Exception('Password must be at least 6 characters');
      }

      // Simulate successful login
      final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        username: email.split('@')[0],
        email: email,
      );

      await _storageService.saveUserData(user.toJson());
      _currentUser = user;
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  Future<void> register(String username, String email, String password) async {
    try {
      // Validate input
      if (username.isEmpty || email.isEmpty || password.isEmpty) {
        throw Exception('All fields are required');
      }

      if (!email.contains('@')) {
        throw Exception('Please enter a valid email address');
      }

      if (password.length < 6) {
        throw Exception('Password must be at least 6 characters');
      }

      // Simulate successful registration
      final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        username: username,
        email: email,
      );

      await _storageService.saveUserData(user.toJson());
      _currentUser = user;
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    await _storageService.removeUserData();
    _currentUser = null;
  }

  Future<void> updateProfile(String username, String? avatarUrl) async {
    try {
      if (_currentUser == null) {
        throw Exception('No user logged in');
      }

      if (username.isEmpty) {
        throw Exception('Username cannot be empty');
      }

      final updatedUser = _currentUser!.copyWith(
        username: username,
        avatarUrl: avatarUrl,
      );

      await _storageService.saveUserData(updatedUser.toJson());
      _currentUser = updatedUser;
    } catch (e) {
      throw Exception('Profile update failed: ${e.toString()}');
    }
  }
}
