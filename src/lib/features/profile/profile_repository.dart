import 'package:todo_apps/app/app.locator.dart';
import 'package:todo_apps/models/user.dart';
import 'package:todo_apps/services/auth_service.dart';

class ProfileRepository {
  final _authService = locator<AuthService>();

  ProfileRepository();

  User? get currentUser => _authService.currentUser;

  Future<void> updateProfile(String username, String? avatarUrl) async {
    await _authService.updateProfile(username, avatarUrl);
  }
}
