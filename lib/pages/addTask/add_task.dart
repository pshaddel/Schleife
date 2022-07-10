import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:weekday_selector/weekday_selector.dart';
import './submit_button.dart';
import '../../database/task.model.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late TextEditingController _controller;
  var color = const Color(0xfff44336);
  var db;
  var submitButtonState = ButtonState.idle;
  var isSaving = false;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  // ignore: unused_element
  void _appInitialization() async {
    db = await TaskModel.db();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// weekdays starting by monday
  var weekDays = List.filled(7, true);

  save() async {
    try {
      isSaving = true;
      setState(() {
        submitButtonState = ButtonState.loading;
      });
      await TaskModel.createTask(_controller.text, color.value, weekDays);
      await Future.delayed(Duration(milliseconds: 200));
      // print(await TaskModel.getTasks());
      isSaving = false;
      setState(() {
        submitButtonState = ButtonState.success;
        _controller.text = '';
        weekDays = List.filled(7, true);
        color = const Color(0xfff44336);
      });
      await Future.delayed(Duration(seconds: 2));
      setState(() {
        submitButtonState = ButtonState.idle;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        submitButtonState = ButtonState.fail;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListView(
          addAutomaticKeepAlives: true,
          padding: const EdgeInsets.fromLTRB(20, 120, 20, 20),
          shrinkWrap: true,
          children: [
            TextField(
                controller: _controller,
                onChanged: (context) {
                  if (submitButtonState != ButtonState.idle) {
                    setState(() {
                      submitButtonState = ButtonState.idle;
                    });
                  }
                },
                style: const TextStyle(fontSize: 23, color: Colors.white),
                maxLength: 100,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  focusColor: Colors.amber,
                  prefixIconColor: Colors.amber,
                  hintText: 'Habit',
                  hintStyle: const TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white10, width: 0),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 0),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  // filled: true,
                  // labelText: 'Your Task',
                )),
            MaterialColorPicker(
                onColorChange: (Color color) {
                  print(color.toString());
                  setState(() {
                    this.color = color;
                  });
                },
                circleSize: 35,
                selectedColor: color),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue[200],
                // boxShadow: [
                //   BoxShadow(color: Colors.green, spreadRadius: 3),
                // ],
              ),
              child: WeekdaySelector(
                onChanged: (int day) {
                  setState(() {
                    // Use module % 7 as Sunday's index in the array is 0 and
                    // DateTime.sunday constant integer value is 7.
                    final index = day % 7;
                    // We "flip" the value in this example, but you may also
                    // perform validation, a DB write, an HTTP call or anything
                    // else before you actually flip the value,
                    // it's up to your app's needs.
                    weekDays[index] = !weekDays[index];
                  });
                },
                values: weekDays,
              ),
            )
          ]),
      const Spacer(),
      Submit(onSubmitFunction: save, state: submitButtonState)
      // Submit(onSubmitFunction: save, state: ButtonState.idle)
    ]);
  }
}
