import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_apps/app/app.locator.dart';
import 'package:todo_apps/app/app.router.dart';
import 'package:todo_apps/features/auth/auth_repository.dart';

class LoginViewModel extends BaseViewModel {
  final _authRepository = locator<AuthRepository>();
  final _navigationService = locator<NavigationService>();

  String _email = '';
  String _password = '';

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  Future<void> login() async {
    try {
      setBusy(true);
      await _authRepository.login(_email, _password);
      await _navigationService.replaceWithTodoView();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  void navigateToRegister() {
    _navigationService.navigateToRegisterView();
  }
}
