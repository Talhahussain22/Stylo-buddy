import 'package:flutter/material.dart';

class TextFormForEmail extends StatelessWidget {
  TextEditingController controller;
  Icon icon;
  String? hinttext;
  Widget suffix;
  TextFormForEmail(
      {super.key,
        required this.controller,
        required this.icon,
        required this.hinttext,
        required this.suffix});

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
            suffix:suffix,
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10))),

      ),
    );
  }
}
