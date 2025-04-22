import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stylo_buddy/ViewModel/LoginAndSignUp.dart';
import 'package:stylo_buddy/ViewModel/ThemeProvider.dart';
import 'package:stylo_buddy/Views/LoginPage.dart';
import 'package:stylo_buddy/res/Components/MyButton.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final themeprovider = Provider.of<ThemeProvider>(context);
    final loginProvider = Provider.of<LoginAndSignUp>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Image.asset("asset/images/appicon.png", height: 200, width: 200),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Dark mode",
                        style: TextStyle(
                          color: themeprovider.isDark ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      Switch(
                        value: themeprovider.isDark,
                        onChanged: (val) {
                          themeprovider.toggletheme();
                        },
                      ),
                    ],
                  ),
                ),

              ],

            ),
            Column(
              children: [
                Mybutton(
                  buttonText: "Log out",
                  onTap: () async {
                    if (await loginProvider.LogOut(context) == true) {
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context){
                        return LoginPage();
                      }));
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
