import 'package:todo_apps/models/user.dart';
import 'package:todo_apps/services/auth_service.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);

  User? get currentUser => _authService.currentUser;
  bool get isAuthenticated => _authService.isAuthenticated;

  Future<void> login(String email, String password) async {
    try {
      await _authService.login(email, password);
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  Future<void> register(String username, String email, String password) async {
    try {
      await _authService.register(username, email, password);
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    try {
      await _authService.logout();
    } catch (e) {
      throw Exception('Logout failed: ${e.toString()}');
    }
  }

  Future<void> updateProfile(String username, String? avatarUrl) async {
    try {
      await _authService.updateProfile(username, avatarUrl);
    } catch (e) {
      throw Exception('Profile update failed: ${e.toString()}');
    }
  }
}
