import 'package:flutter/material.dart';

class EmailFeild extends StatelessWidget {
  TextEditingController controller;
  EmailFeild({super.key,required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        style: TextStyle(color: Colors.black),
        cursorColor: Colors.black,
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(

          focusColor: Colors.transparent,
          focusedBorder:OutlineInputBorder(
            borderSide: const BorderSide(color:Colors.black26),
            borderRadius: BorderRadius.circular(10),
          ) ,
          contentPadding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.black12)),

        ),

      ),
    );
  }
}
