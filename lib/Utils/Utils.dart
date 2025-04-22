import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils
{
  static void ShowFlushBar(BuildContext context,String message,Color color)
  {
    showFlushbar(context: context, flushbar: Flushbar(
      borderRadius: BorderRadius.circular(10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      padding: const EdgeInsets.only(left: 30, top: 15, bottom: 15),
      message: message,
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: color,
      messageColor: Colors.black,
      duration: Duration(seconds: 3),

    )..show(context));
  }
}