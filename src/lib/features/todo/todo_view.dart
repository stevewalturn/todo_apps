import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_apps/features/todo/todo_viewmodel.dart';
import 'package:todo_apps/features/todo/widgets/todo_item.dart';
import 'package:todo_apps/ui/common/ui_helpers.dart';

class TodoView extends StackedView<TodoViewModel> {
  const TodoView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TodoViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: viewModel.navigateToProfile,
          ),
        ],
      ),
      body: Column(
        children: [
          if (viewModel.modelError != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                viewModel.modelError.toString(),
                style: const TextStyle(color: Colors.red),
              ),
            ),
          Expanded(
            child: viewModel.isBusy
                ? const Center(child: CircularProgressIndicator())
                : viewModel.todos.isEmpty
                    ? const Center(child: Text('No todos yet'))
                    : ListView.builder(
                        itemCount: viewModel.todos.length,
                        itemBuilder: (context, index) {
                          final todo = viewModel.todos[index];
                          return TodoItem(
                            todo: todo,
                            onToggle: viewModel.toggleTodoComplete,
                            onDelete: viewModel.deleteTodo,
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final dialogService = DialogService();
          final response = await dialogService.showCustomDialog(
            variant: DialogType.custom,
            customData: const AddTodoDialogData(),
          );

          if (response?.confirmed ?? false) {
            await viewModel.addTodo(
              response!.data['title'],
              response.data['description'],
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  TodoViewModel viewModelBuilder(BuildContext context) => TodoViewModel();

  @override
  void onViewModelReady(TodoViewModel viewModel) => viewModel.init();
}
