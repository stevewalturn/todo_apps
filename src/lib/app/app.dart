import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_apps/features/auth/login_view.dart';
import 'package:todo_apps/features/auth/register_view.dart';
import 'package:todo_apps/features/profile/profile_view.dart';
import 'package:todo_apps/features/todo/todo_view.dart';
import 'package:todo_apps/services/auth_service.dart';
import 'package:todo_apps/services/storage_service.dart';
import 'package:todo_apps/services/todo_service.dart';
import 'package:todo_apps/features/auth/auth_repository.dart';
import 'package:todo_apps/features/profile/profile_repository.dart';
import 'package:todo_apps/features/todo/todo_repository.dart';
import 'package:todo_apps/features/todo/widgets/add_todo_dialog.dart';
import 'package:todo_apps/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:todo_apps/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:todo_apps/ui/views/startup/startup_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: RegisterView),
    MaterialRoute(page: TodoView),
    MaterialRoute(page: ProfileView),
  ],
  dependencies: [
    InitializableSingleton(classType: StorageService),
    InitializableSingleton(classType: AuthService),
    InitializableSingleton(classType: TodoService),
    LazySingleton(classType: AuthRepository),
    LazySingleton(classType: ProfileRepository),
    LazySingleton(classType: TodoRepository),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: AddTodoDialog),
  ],
)
class App {}
