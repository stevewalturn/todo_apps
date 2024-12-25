import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_apps/ui/common/ui_helpers.dart';

class AddTodoDialog extends StatefulWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const AddTodoDialog({
    required this.request,
    required this.completer,
    Key? key,
  }) : super(key: key);

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add New Todo',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpaceMedium,
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            verticalSpaceSmall,
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    widget.completer(DialogResponse(confirmed: false));
                  },
                  child: const Text('Cancel'),
                ),
                horizontalSpaceSmall,
                ElevatedButton(
                  onPressed: () {
                    if (_titleController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter a title')),
                      );
                      return;
                    }
                    widget.completer(
                      DialogResponse(
                        confirmed: true,
                        data: {
                          'title': _titleController.text,
                          'description': _descriptionController.text,
                        },
                      ),
                    );
                  },
                  child: const Text('Add Todo'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
