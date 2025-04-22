

import 'package:app_links/app_links.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:stylo_buddy/Utils/Utils.dart';
import 'package:stylo_buddy/Views/GeneralPage.dart';

import 'package:stylo_buddy/Views/LoginPage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Views/ResetPasswordScreen.dart';

class LoginAndSignUp extends ChangeNotifier {
  bool _loading = false;

  void SignUp(String email, String password, BuildContext context) async {
    _loading = true;
    notifyListeners();

    if (email.isEmpty || password.isEmpty) {
      Utils.ShowFlushBar(
        context,
        "Email or password can't be empty",
        Colors.red,
      );
      _loading = false;
      notifyListeners();
      return;
    } else if (password.length < 8) {
      Utils.ShowFlushBar(context, "Password should be of length 8", Colors.red);
      _loading = false;
      notifyListeners();
      return;
    } else if (!email.endsWith("@gmail.com")) {
      Utils.ShowFlushBar(context, "Invalid Email", Colors.red);
      _loading = false;
      notifyListeners();
      return;
    }


    try {
      final supabase = Supabase.instance.client;
      AuthResponse response = await supabase.auth.signUp(
        password: password,
        email: email,
      );

      _loading = false;
      notifyListeners();
      Future.microtask(() {
        Utils.ShowFlushBar(
          context,
          "Congratulations Successfully Registered\nWelcome to Stylo Buddy",
          Colors.green,
        );
      });
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginPage();
          },
        ),
        (Route<dynamic> route) => false,
      );
    } catch (e) {

      String error=getError(e.toString());
      Utils.ShowFlushBar(context, error, Colors.red);

      _loading = false;
      notifyListeners();
    }
  }

  void Login(String email, String password, BuildContext context) async {
    if (email.isEmpty || password.isEmpty) {
      Utils.ShowFlushBar(
        context,
        "Email or password can't be empty",
        Colors.red,
      );
      _loading = false;
      notifyListeners();
      return;
    } else if (password.length < 8) {
      Utils.ShowFlushBar(context, "Password should be of length 8", Colors.red);
      _loading = false;
      notifyListeners();
      return;
    } else if (!email.endsWith("@gmail.com")) {
      Utils.ShowFlushBar(context, "Invalid Email", Colors.red);
      _loading = false;
      notifyListeners();
      return;
    }



    _loading = true;
    notifyListeners();
    try {
      final supabase = Supabase.instance.client;
      await supabase.auth.signInWithPassword(password: password, email: email);
      _loading = false;
      notifyListeners();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Generalpage();
          },
        ),
      );
    } catch (e) {
      String error=getError(e.toString());

      Utils.ShowFlushBar(context, error, Colors.red);
      _loading = false;
      notifyListeners();
    }
  }

  void configDeepLink(BuildContext context) {
    final appLinks = AppLinks();

    appLinks.uriLinkStream.listen((uri) {
      if (uri.host == 'reset-password') {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => ResetPasswordScreen(),));
      }
    });
  }

  void resetPassword(String newpassword,BuildContext context) async
  {

    if(newpassword.length<8)
      {
        Utils.ShowFlushBar(context,"Password should be of length 8" ,Colors.red);
        return;
      }
    try
        {
          _loading=true;
          notifyListeners();
          final supabse=Supabase.instance.client;
          await supabse.auth.updateUser(UserAttributes(password: newpassword));
          Utils.ShowFlushBar(context,"Successfully reset the password!", Colors.green);
          _loading=false;
          notifyListeners();


        }catch(e)
    {
      String errormsg=getError(e.toString());
      Utils.ShowFlushBar(context, errormsg, Colors.red);
      _loading=false;
      notifyListeners();
    }
  }
  void forgotPassword(String email,BuildContext context) async
  {

    if(!email.endsWith("@gmail.com"))
      {
        Utils.ShowFlushBar(context,"Invalid email", Colors.red);
        return;
      }
    try
        {
          _loading=true;
          notifyListeners();
          final supabase=await Supabase.instance.client;
          await supabase.auth.resetPasswordForEmail(email,redirectTo: 'stylobuddy://reset-password');
          Utils.ShowFlushBar(context,"Password Reset link sent to email",Colors.green);
          _loading=false;
          notifyListeners();
        } catch(e)
    {
      String error=getError(e.toString());
      Utils.ShowFlushBar(context, error, Colors.red);
      _loading=false;
      notifyListeners();
    }

  }
  Future<bool> LogOut(BuildContext context) async
  {
    try
        {
          final supabase=await Supabase.instance.client;
          await supabase.auth.signOut();
          return true;

        }catch(e)
    {
      String errorMessage=getError(e.toString());
      Utils.ShowFlushBar(context,errorMessage, Colors.red);
      return false;
    }
  }

  bool getisloading() => _loading;
}

String getError(String error)
{
  String errorMessage;
  if(error.contains("invalid_credentials"))
    {
      errorMessage="Account doesn't exists\nCheck your credentials.";
    }
  else if(error.contains("user_already_exists"))
    {
      errorMessage = "An account already exists with this email.";
    }
  else if (error.contains("Failed host lookup") || error.contains("SocketException")) {
    errorMessage = "Network error.\nPlease check your internet connection.";
  } else {
    errorMessage = "An unexpected error occurred.\nPlease try again later.";
  }



  return errorMessage;
}
