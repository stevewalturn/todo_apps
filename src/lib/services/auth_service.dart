import 'package:injectable/injectable.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:todo_apps/app/app.locator.dart';
import 'package:todo_apps/models/user.dart';
import 'package:todo_apps/services/storage_service.dart';

@lazySingleton
class AuthService implements InitializableDependency {
  final _storageService = locator<StorageService>();
  
  User? _currentUser;
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
    // Mock implementation
    _currentUser = User(
      id: '1',
      email: email,
      username: email.split('@')[0],
      avatarUrl: null,
    );
    await _storageService.saveUserData(_currentUser!.toJson());
  }

  Future<void> register(String username, String email, String password) async {
    // Mock implementation
    _currentUser = User(
      id: '1',
      email: email,
      username: username,
      avatarUrl: null,
    );
    await _storageService.saveUserData(_currentUser!.toJson());
  }

  Future<void> logout() async {
    _currentUser = null;
    await _storageService.removeUserData();
  }

  Future<void> updateProfile(String username, String? avatarUrl) async {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(
        username: username,
        avatarUrl: avatarUrl,
      );
      await _storageService.saveUserData(_currentUser!.toJson());
    }
  }
}