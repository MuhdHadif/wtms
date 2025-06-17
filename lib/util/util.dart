import 'package:flutter/material.dart';
import 'package:wtms/style/style.dart';

class Util {
  static TextField createInputField(String label, TextEditingController controller){
    return TextField(
      controller: controller,
      decoration: Style.inputDecoration.copyWith(
        labelText: label
      ),
      keyboardType: TextInputType.text,
    );
  }

  static TextField createFilledInputField(String label, String content, TextEditingController controller, [int maxLines = 1]){
    controller.text = content;
    return TextField(
      controller: controller,
      decoration: Style.inputDecoration.copyWith(
        labelText: label
      ),
      maxLines: maxLines,
      keyboardType: TextInputType.text,
    );
  }

  static TextField createTextField(String label, String content, TextEditingController controller, [int maxLines = 1, double maxWidth = double.infinity]){
    controller.text = content;
    return TextField(
      enabled: false,
      controller: controller,
      decoration: Style.textFieldDecoration.copyWith(
        labelText: label
      ),
      maxLines: maxLines,
      style: TextStyle(color: Colors.black)
    );
  }

  static SizedBox createSizedTextField(String label, String content, TextEditingController controller, [double width = double.infinity, int maxLines = 1]){
    controller.text = content;
    return SizedBox(
      width: width,
      child: TextField(
        enabled: false,
        controller: controller,
        decoration: Style.textFieldDecoration.copyWith(
          labelText: label,
          contentPadding: EdgeInsets.all(8),
          // isDense: true,
          border: InputBorder.none
        ),
        maxLines: maxLines,
        style: TextStyle(
          color: Colors.black
        )
      ),
    );
  }
}

extension StringCasingExtension on String {
  String get toCapitalized => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String get toTitleCase => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized).join(' ');
}