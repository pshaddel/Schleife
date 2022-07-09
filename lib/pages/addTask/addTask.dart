import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  // int _selectedIndex = 0;
  // static const TextStyle optionStyle = TextStyle(
  //     fontSize: 30,
  //     fontWeight: FontWeight.bold,
  //     color: Colors.white,
  //     backgroundColor: Colors.blueAccent);

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  // final tasks = <Widget>[
  //   Task(),
  //   SizedBox(height: 5),
  //   Task(),
  //   SizedBox(height: 5),
  //   Task(),
  //   SizedBox(height: 5),
  //   Task(),
  //   SizedBox(height: 5),
  //   Task()
  // ];;
  // }

  late TextEditingController _controller;

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
            // style: TextStyle(color: Colors.white),
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
      ],
    );
  }
}
