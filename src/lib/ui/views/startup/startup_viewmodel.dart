import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_apps/app/app.locator.dart';
import 'package:todo_apps/app/app.router.dart';
import 'package:todo_apps/services/auth_service.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();

  Future<void> runStartupLogic() async {
    try {
      await Future.delayed(const Duration(seconds: 3));

      if (_authService.isAuthenticated) {
        await _navigationService.replaceWithTodoView();
      } else {
        await _navigationService.replaceWithLoginView();
      }
    } catch (e) {
      setError('Failed to initialize app: Please restart the application');
    }
  }
}
