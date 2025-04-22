import 'package:stylo_buddy/Utils/Utils.dart';
import 'package:stylo_buddy/Views/GeneralPage.dart';
import 'package:stylo_buddy/Views/LoginPage.dart';
import 'package:stylo_buddy/Views/SignUpPage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
class Authclass extends StatelessWidget {
  const Authclass({super.key});

  @override
  Widget build(BuildContext context) {
    _checkUserStatus(context);
    return Center(child: CircularProgressIndicator(color: Colors.black,),);
  }
   void _checkUserStatus(BuildContext context) async
  {

    try
        {
          User? user=await Supabase.instance.client.auth.currentUser;


          if(user!=null)
            {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                return Generalpage();
              }));

            }
          else
            {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                return LoginPage();
              }));
            }
        }catch(e)
    {
      Utils.ShowFlushBar(context, e.toString(), Colors.red);


    }
  }
}

