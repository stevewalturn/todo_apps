import 'package:todo_apps/models/user.dart';
import 'package:todo_apps/services/auth_service.dart';

class ProfileRepository {
  final AuthService _authService;

  ProfileRepository(this._authService);

  User? get currentUser => _authService.currentUser;

  Future<void> updateProfile(String username, String? avatarUrl) async {
    try {
      await _authService.updateProfile(username, avatarUrl);
    } catch (e) {
      throw Exception('Failed to update profile: ${e.toString()}');
    }
  }
}
