import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:world/pages/taskList/task_button.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  listGenerator() {
    final tasks = <Widget>[];
    for (var i = 0; i < 20; i++) {
      tasks.addAll([
        Task(
            description: 'Work out',
            isChecked: false,
            color: Colors.red,
            taskId: i.toString()),
        const SizedBox(height: 10)
      ]);
    }
    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: listGenerator(),
      addAutomaticKeepAlives: true,
      padding: const EdgeInsets.fromLTRB(20, 120, 20, 20),
    );
  }
}
