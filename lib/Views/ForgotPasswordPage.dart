import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stylo_buddy/ViewModel/LoginAndSignUp.dart';
import 'package:stylo_buddy/res/Components/EmailFeild.dart';
import 'package:stylo_buddy/res/Components/MyButton.dart';

class Forgotpasswordpage extends StatefulWidget {
  Forgotpasswordpage({super.key});

  @override
  State<Forgotpasswordpage> createState() => _ForgotpasswordpageState();
}

class _ForgotpasswordpageState extends State<Forgotpasswordpage> {
  TextEditingController emailController=TextEditingController();

  @override
  void dispose() {

    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final provider=Provider.of<LoginAndSignUp>(context);
    return SafeArea(

      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon:Icon(Icons.arrow_back,)),),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Center(child: Text("Forgot Password?",style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  child: Text("Email",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)),
                ),

                EmailFeild(controller: emailController),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Column(

                children: [
                  provider.getisloading()==false ?Mybutton(buttonText: "Reset Password", onTap: () {
                    provider.forgotPassword(emailController.text.toString(), context);
                  }): Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade800,
                        borderRadius: BorderRadius.circular(30),



                      ),
                      child: Center(child: CircularProgressIndicator(color: Colors.white,)),),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
