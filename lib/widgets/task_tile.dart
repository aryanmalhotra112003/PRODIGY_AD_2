import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  const TaskTile(
      {super.key,
      required this.onLongPress,
      required this.taskTitle,
      required this.isChecked,
      required this.op,
      required this.onTap});
  final Function()? onLongPress;
  final Function()? onTap;
  final bool isChecked;
  final String taskTitle;
  final void Function(bool?) op;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      onLongPress: onLongPress,
      title: Text(
        taskTitle,
        style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
        activeColor: Colors.deepPurpleAccent.shade100,
        value: isChecked,
        onChanged: op,
      ),
    );
  }
}
