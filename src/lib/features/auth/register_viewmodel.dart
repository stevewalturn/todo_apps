import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_apps/app/app.locator.dart';
import 'package:todo_apps/app/app.router.dart';
import 'package:todo_apps/features/auth/auth_repository.dart';

class RegisterViewModel extends BaseViewModel {
  final _authRepository = locator<AuthRepository>();
  final _navigationService = locator<NavigationService>();

  String _username = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
    notifyListeners();
  }

  Future<void> register() async {
    try {
      if (_password != _confirmPassword) {
        throw Exception('Passwords do not match');
      }

      setBusy(true);
      await _authRepository.register(_username, _email, _password);
      await _navigationService.replaceWithTodoView();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  void navigateToLogin() {
    _navigationService.replaceWithLoginView();
  }
}
