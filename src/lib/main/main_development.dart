import 'package:todo_apps/main/bootstrap.dart';
import 'package:todo_apps/models/enums/flavor.dart';
import 'package:todo_apps/ui/views/app/app_view.dart';

void main() {
  bootstrap(
    builder: () => const AppView(),
    flavor: Flavor.development,
  );
}
