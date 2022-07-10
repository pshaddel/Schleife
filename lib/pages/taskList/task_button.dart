import 'dart:async';
import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

class Task extends StatefulWidget {
  const Task(
      {Key? key,
      required this.description,
      required this.color,
      required this.isChecked,
      required this.taskId})
      : super(key: key);

  final String taskId;
  // final String title = 'test';
  final String description;
  final Color color;
  final bool isChecked;
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
      children: [checkbox(), buildTextWithIcon()],
    );
  }

  Widget buildTextWithIcon() {
    return ProgressButton(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
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
          setState(() {
            isChecked = value!;
          });
        });
  }

  onPressedIconWithText() {}
}
