import 'package:flutter/material.dart';

class Style {
  static const InputDecoration inputDecoration = InputDecoration(
    filled: true,
    fillColor: Color.fromARGB(255, 246, 246, 246),
    border: OutlineInputBorder(     
      borderSide: BorderSide.none,
    ),
    labelStyle: TextStyle(
      fontWeight: FontWeight.bold
    )
  );

  static const InputDecoration textFieldDecoration = InputDecoration(
    border: OutlineInputBorder(     
      borderSide: BorderSide(color: Colors.black)
    ),
    labelStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  );
}