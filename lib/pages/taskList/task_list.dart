import 'package:flutter/material.dart';
import 'package:Schleife/pages/taskList/task_button.dart';
import '../../database/task.model.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  var db;

  List<Widget> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks(); // Loading the diary when the app starts
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadTasks() async {
    print('calling database for fetching tasks...');
    // if (tasks.length > 0) return;
    // var dateTimeOld = DateTime.now();
    db = await TaskModel.db();
    var data = await TaskModel.getTasks();
    // print(DateTime.now().difference(dateTimeOld).inMilliseconds);
    // {id: 1, title: something, monday: 1, tuesday: 1, wednesday: 1, thursday: 1, friday: 0, saturday: 0, sunday: 0, color: Color(0xff795548), createdAt: 2022-07-10 11:01:07}
    List<Widget> databaseTasks = [];
    for (var element in data) {
      databaseTasks.add(Task(
        description: element['title'],
        isChecked: element['completed'] == 1 ? true : false,
        taskId: element['id'],
        onDelete: () async {
          await TaskModel.deleteTask(element['id']);
          loadTasks();
        },
        color: Color(element['color']),
        onChecked: (bool newValue) {
          TaskModel.checkTask(element['id'], newValue);
        },
      ));
      databaseTasks.add(const SizedBox(
        height: 10,
      ));
    }

    if (databaseTasks.isEmpty) {
      databaseTasks.add(const Center(
          child: Text(
        'You Do Not Have Any Task!',
        style: const TextStyle(color: Colors.white, fontSize: 22),
      )));

      databaseTasks.add(const SizedBox(
        height: 50,
      ));
      databaseTasks.add(
        Row(children: [
          const Text(
            'Use This ',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(2)),
            child: const Icon(
              Icons.add,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {},
          ),
          const Text(
            'to Add Some Tasks :)',
            style: const TextStyle(color: Colors.white, fontSize: 22),
          )
        ]),
      );
    }

    if (!mounted) return;

    setState(() {
      tasks = databaseTasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      addAutomaticKeepAlives: true,
      padding: const EdgeInsets.fromLTRB(20, 120, 20, 20),
      children: tasks,
    );
  }
}
