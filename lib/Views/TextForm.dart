import 'package:flutter/material.dart';

class Textform extends StatelessWidget {
  TextEditingController controller;
  Icon icon;
  String? hinttext;
  Textform(
      {super.key,
        required this.controller,
        required this.icon,
        required this.hinttext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
            hintText: hinttext,
            hintStyle: TextStyle(color: Colors.grey[50]),
            fillColor: Colors.grey,
            filled: true,
            prefixIcon: icon,
            prefixIconColor: Colors.white,
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
