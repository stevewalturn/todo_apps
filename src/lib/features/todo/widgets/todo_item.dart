import 'package:flutter/material.dart';
import 'package:todo_apps/ui/common/app_colors.dart';
import 'package:todo_apps/ui/common/ui_helpers.dart';

class TodoItem extends StatelessWidget {
  final Map<String, dynamic> todo;
  final Function(String) onToggle;
  final Function(String) onDelete;

  const TodoItem({
    required this.todo,
    required this.onToggle,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Checkbox(
          value: todo['completed'] as bool,
          onChanged: (_) => onToggle(todo['id'] as String),
        ),
        title: Text(
          todo['title'] as String,
          style: TextStyle(
            decoration: (todo['completed'] as bool)
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            color: (todo['completed'] as bool) ? kcMediumGrey : Colors.black,
          ),
        ),
        subtitle: Text(
          todo['description'] as String,
          style: TextStyle(
            color: (todo['completed'] as bool) ? kcLightGrey : kcMediumGrey,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => onDelete(todo['id'] as String),
        ),
      ),
    );
  }
}
