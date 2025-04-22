import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Mybutton extends StatelessWidget {
  String buttonText;
  VoidCallback onTap;
  Mybutton({super.key,required this.buttonText,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.blue.shade800,
            borderRadius: BorderRadius.circular(30),
            
            
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            
            children: [
              Padding(padding: EdgeInsets.symmetric(horizontal: 20),child: Text(buttonText,style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w600),),),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: FaIcon(FontAwesomeIcons.arrowRight,color: Colors.white,size: 20,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
