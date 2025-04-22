import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stylo_buddy/ViewModel/LoginAndSignUp.dart';
import 'package:stylo_buddy/Views/ForgotPasswordPage.dart';
import 'package:stylo_buddy/Views/SignUpPage.dart';
import 'package:stylo_buddy/res/Components/EmailFeild.dart';
import 'package:stylo_buddy/res/Components/MyButton.dart';
import 'package:stylo_buddy/res/Components/PasswordFeild.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  double? screenHeight, screenWidth;

  @override
  void dispose() {

    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  void initState() {

    super.initState();

    final provider =Provider.of<LoginAndSignUp>(context,listen: false);
    provider.configDeepLink(context);

  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginAndSignUp>(context);
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
              child: Container(
                height: screenHeight! * 0.25,
                width: double.infinity,

                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(30),
                    topEnd: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight! * 0.08),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 2,
                      ),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 40,
                          ),
                          text: "Login",
                          children: [
                            TextSpan(text: " "),
                            TextSpan(
                              text: "Account",
                              style: TextStyle(
                                fontFamily: "PlayDesk",
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SignUpPage();
                              },
                            ),
                          );
                        },
                        child: Container(
                          height: 35,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 5,
                                ),
                                child: Text(
                                  "Haven't account yet?",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    wordSpacing: 0.01,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 25),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Text(
                "Email Address",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            EmailFeild(controller: emailController),
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Text(
                "Password",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            PasswordFeild(controller: passwordController),

            SizedBox(height: screenHeight! * 0.05),
            loginProvider.getisloading()==false ?Mybutton(buttonText: "Login Now!", onTap: () {
              loginProvider.Login(emailController.text.toString(), passwordController.text.toString(), context);
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

            SizedBox(height: screenHeight! * 0.03),
            Center(
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return Forgotpasswordpage();
                  }));
                },
                child: Container(
                  height: 30,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black26),
                  ),
                  child: Center(
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        wordSpacing: 0.01,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
