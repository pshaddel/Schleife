import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late TextEditingController _controller;
  var color;
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      addAutomaticKeepAlives: true,
      padding: const EdgeInsets.fromLTRB(20, 120, 20, 20),
      children: [
        TextField(
            controller: _controller,
            autofocus: false,
            obscureText: false,
            maxLength: 100,
            decoration: InputDecoration(
              fillColor: Colors.white,
              focusColor: Colors.amber,
              prefixIconColor: Colors.amber,
              hintText: 'Reading a Book',
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white10, width: 1.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              filled: true,
              labelText: 'Your Task',
            )),
        MaterialColorPicker(
            onColorChange: (Color color) {
              setState(() {
                this.color = color;
              });
            },
            circleSize: 35,
            // colors: [
            //   Colors.red,
            //   Colors.deepOrange,
            //   Colors.yellow,
            //   Colors.lightGreen
            // ],
            selectedColor: color),
      ],
    );
  }
}
