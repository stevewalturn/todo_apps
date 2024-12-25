import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_apps/app/app.locator.dart';
import 'package:todo_apps/app/app.router.dart';
import 'package:todo_apps/features/auth/auth_repository.dart';
import 'package:todo_apps/features/profile/profile_repository.dart';
import 'package:todo_apps/models/user.dart';

class ProfileViewModel extends BaseViewModel {
  final _profileRepository = locator<ProfileRepository>();
  final _authRepository = locator<AuthRepository>();
  final _navigationService = locator<NavigationService>();

  User? get user => _profileRepository.currentUser;

  String _username = '';
  String? _avatarUrl;

  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }

  void setAvatarUrl(String? avatarUrl) {
    _avatarUrl = avatarUrl;
    notifyListeners();
  }

  Future<void> updateProfile() async {
    try {
      setBusy(true);
      await _profileRepository.updateProfile(_username, _avatarUrl);
      setError('Profile updated successfully');
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<void> logout() async {
    try {
      setBusy(true);
      await _authRepository.logout();
      await _navigationService.replaceWithLoginView();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  void init() {
    if (user != null) {
      _username = user!.username;
      _avatarUrl = user!.avatarUrl;
    }
  }
}
