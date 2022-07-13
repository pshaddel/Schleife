import 'package:flutter/material.dart';
import 'package:progress_state_button/progress_button.dart';

import '../../database/task.model.dart';

class Task extends StatefulWidget {
  const Task(
      {Key? key,
      required this.description,
      required this.color,
      required this.isChecked,
      required this.onChecked,
      required this.onDelete,
      required this.taskId})
      : super(key: key);
  final onChecked;
  final int taskId;
  // final String title = 'test';
  final String description;
  final Color color;
  final bool isChecked;
  final onDelete;
  @override
  TaskState createState() => TaskState();
}

class TaskState extends State<Task> {
  ButtonState stateOnlyText = ButtonState.idle;
  ButtonState stateOnlyCustomIndicatorText = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;
  ButtonState stateTextWithIconMinWidthState = ButtonState.idle;

  final description = 'widget.description';

  final color = Colors.blueAccent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        checkbox(),
        progressButtonWidget(),
        PopupMenuButton(
          splashRadius: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onSelected: (value) {
            switch (value) {
              case 'delete':
                widget.onDelete();
                break;
              case 'edit':
                print('edit');
                break;
              default:
            }
          },
          itemBuilder: (BuildContext bc) {
            return const [
              PopupMenuItem(
                value: 'delete',
                child: Text("Delete"),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Text("Edit"),
              ),
              PopupMenuItem(
                value: 'coffee',
                child: Text("Take a Break this time"),
              )
            ];
          },
        )
        // IconButton(
        //     onPressed: () async {
        //       await TaskModel.deleteTask(widget.taskId);
        //     },
        //     icon: const Icon(Icons.delete))
      ],
    );
  }

  Widget progressButtonWidget() {
    return ProgressButton(
        maxWidth: MediaQuery.of(context).size.width * 0.65,
        stateWidgets: {
          ButtonState.idle: const Text(
            "Idle",
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          ButtonState.loading: const Text(
            "Loading",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          ButtonState.fail: Text(
            widget.description,
            textAlign: TextAlign.left,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500),
          ),
          ButtonState.success: Text(
            widget.description,
            textAlign: TextAlign.left,
            style:
                TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w500),
          )
        },
        stateColors: {
          ButtonState.idle: Colors.grey.shade400,
          ButtonState.loading: Colors.blue.shade300,
          ButtonState.fail: widget.color.withOpacity(0.8),
          ButtonState.success: Colors.black54,
        },
        onPressed: onPressedIconWithText,
        state: isChecked ? ButtonState.success : ButtonState.fail);
  }

  var isChecked = false;

  Widget checkbox() {
    return Checkbox(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        checkColor: Colors.white,
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.orange.withOpacity(.32);
          }
          return Colors.orange;
        }),
        // fillColor: MaterialState.pressed,
        value: isChecked,
        onChanged: (bool? value) {
          widget.onChecked(value);
          setState(() {
            isChecked = value!;
          });
        });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isChecked = widget.isChecked;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  onPressedIconWithText() {}
}
