import 'package:flutter/material.dart';
import 'task_tile.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/task_data.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return TaskTile(
                onTap: () {
                  final TextEditingController controller =
                      TextEditingController(
                    text: taskData.tasks[index].name,
                  );

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      title: const Text(
                        'Rename Task',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.purple),
                      ),
                      content: TextField(
                        controller: controller,
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: 'Enter new task name',
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.purple),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: const Text(
                            'Save',
                            style: TextStyle(color: Colors.purple),
                          ),
                          onPressed: () {
                            final newName = controller.text.trim();
                            if (newName.isNotEmpty) {
                              Provider.of<TaskData>(context, listen: false)
                                  .renameTask(index, newName);
                            }
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
                onLongPress: () {
                  Provider.of<TaskData>(context, listen: false)
                      .deleteTask(index);
                },
                taskTitle: taskData.tasks[index].name,
                isChecked: taskData.tasks[index].isDone,
                op: (bool? newValue) {
                  taskData.updateTask(taskData.tasks[index]);
                });
          },
          itemCount: taskData.tasksCount,
        );
      },
    );
  }
}
