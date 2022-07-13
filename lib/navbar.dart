import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:Schleife/pages/addTask/add_task.dart';
import 'pages/taskList/task_list.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedIndex = 1;
  static const TextStyle optionStyle = TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      backgroundColor: Colors.blueAccent);
  static const List<Widget> _widgetOptions = <Widget>[
    AddTask(),
    TaskList(),
    Center(
        child: Text(
      'Profile',
      style: optionStyle,
    )),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        backgroundColor: Colors.blueAccent,
        animationDuration: const Duration(milliseconds: 450),
        items: const <Widget>[
          Icon(Icons.add, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.person, size: 30)
        ],
        onTap: _onItemTapped,
      ),
      body: Container(
          color: Colors.blueAccent, child: _widgetOptions[_selectedIndex]),
    );
  }
}
