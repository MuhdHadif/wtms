import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wtms/model/User.dart';
import 'package:wtms/style/style.dart';
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
  int selectedIndex = 2;
  void onTap(int index) {
      if (selectedIndex != index) {
        setState(() {
          log("index: $index");
          selectedIndex = index;
        });
      }
    }

    final destinations = const [
      BottomNavigationBarItem(icon: Icon(Icons.task), label: "Tasks", backgroundColor: Style.themeColor),
      BottomNavigationBarItem(icon: Icon(Icons.history), label: "History", backgroundColor: Style.themeColor),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile", backgroundColor: Style.themeColor),
    ];

  @override
  Widget build(BuildContext context) {
    final list = [
      Taskscreen(user: widget.user), 
      Taskhistoryscreen(user: widget.user),
      ProfileScreen(userId: widget.user.id.toString()),
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