import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wtms/model/User.dart';
import 'package:wtms/view/profilescreen.dart';
import 'package:wtms/view/taskhistoryscreen.dart';
import 'package:wtms/view/taskscreen.dart';

class Mainscreen extends StatefulWidget {
  final User user;
  const Mainscreen({ super.key, required this.user });

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  int selectedIndex = 0;
  void onTap(int index) {
      if (selectedIndex != index) {
        setState(() {
          log("index: $index");
          selectedIndex = index;
        });
      }
    }

    final destinations = const [
      BottomNavigationBarItem(icon: Icon(Icons.task), label: "Tasks", backgroundColor: Colors.lightBlue),
      BottomNavigationBarItem(icon: Icon(Icons.history), label: "History", backgroundColor: Colors.lightBlue),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile", backgroundColor: Colors.lightBlue),
    ];

  @override
  Widget build(BuildContext context) {
    final list = [
      Taskscreen(user: widget.user), 
      Taskhistoryscreen(user: widget.user),
      ProfileScreen(user: widget.user),
    ];

    return Scaffold(
      body: list[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: destinations,
        onTap: onTap,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.shifting,
      ),
    );
  }
}