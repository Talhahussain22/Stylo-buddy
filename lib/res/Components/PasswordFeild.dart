import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PasswordFeild extends StatelessWidget {
  TextEditingController controller;
  ValueNotifier<bool> isobsecure=ValueNotifier(false);
  PasswordFeild({super.key,required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ValueListenableBuilder(
        valueListenable: isobsecure,
        builder: (context,value,child){
          return TextField(
            style: TextStyle(color: Colors.black),
            obscureText: isobsecure.value,
            cursorColor: Colors.black,
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              suffixIcon: IconButton(onPressed: (){
                isobsecure.value=!isobsecure.value;
              }, icon:isobsecure.value==false ?FaIcon(FontAwesomeIcons.eye,color: Colors.black,):FaIcon(FontAwesomeIcons.eyeSlash,color: Colors.black,)),
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

          );
        },

      ),
    );
  }
}
