import 'package:todo_apps/app/app.locator.dart';
import 'package:todo_apps/models/user.dart';
import 'package:todo_apps/services/auth_service.dart';

class AuthRepository {
  final _authService = locator<AuthService>();
  
  AuthRepository();

  User? get currentUser => _authService.currentUser;
  bool get isAuthenticated => _authService.isAuthenticated;

  Future<void> login(String email, String password) async {
    await _authService.login(email, password);
  }

  Future<void> register(String username, String email, String password) async {
    await _authService.register(username, email, password);
  }

  Future<void> logout() async {
    await _authService.logout();
  }
}
