import 'package:flutter/material.dart';
import 'package:wtms/model/User.dart';

class Taskhistoryscreen extends StatefulWidget {
  final User user;
  const Taskhistoryscreen({ super.key, required this.user });

  @override
  State<Taskhistoryscreen> createState() => _TaskhistoryscreenState();
}

class _TaskhistoryscreenState extends State<Taskhistoryscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Submitted tasks", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.lightBlue,
      ),
      body: Text("History"),
    );
  }
}