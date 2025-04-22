import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stylo_buddy/Utils/Utils.dart';
import 'package:stylo_buddy/ViewModel/ThemeProvider.dart';
import 'package:stylo_buddy/Views/AuthClass.dart';

import '../ViewModel/DataProvider.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> with TickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    controller=AnimationController(vsync: this,duration: Duration(seconds: 5))..addListener((){
      setState(() {

      });
    })..forward();
    final  provider= Provider.of<DataProvider>(context, listen:false);
    Future.microtask(() {

      provider.FetchData(context).then((_){
        if(provider.IsFetched())
          {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
              return Authclass();
            }),(Route<dynamic> route) =>false);
          }
        else
          {

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
              return Scaffold(
                backgroundColor: Colors.white,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,


                  children: [
                    Padding(padding: EdgeInsets.symmetric(vertical: 100),child: Text("No internet",style: TextStyle(fontSize: 16,color: Colors.red,fontWeight: FontWeight.bold),)),

                    Center(child: Image.asset("asset/images/appicon.png",height: 250,width: 250,)),

                    Text("Stylo Buddy",style: TextStyle(fontFamily: "PlayDesk",fontStyle: FontStyle.italic,fontSize: 40,color: Colors.black),)
                  ],
                ),
              );
            }));
          }}).catchError((error){
            Utils.ShowFlushBar(context,"No internet", Colors.red);
      });


      });







    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,


        children: [
          Center(child: Image.asset("asset/images/appicon.png",height: 250,width: 250,)),

          Text("Stylo Buddy",style: TextStyle(fontFamily: "PlayDesk",fontStyle: FontStyle.italic,fontSize: 40,color: Colors.black),),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 100,vertical: 70),
            child: LinearProgressIndicator(value: controller.value,backgroundColor: Colors.grey[300],color: Colors.pink,
            ),
          )
        ],
      ),
    );
  }
}
