import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stylo_buddy/Data/local/DBHelper.dart';
import 'package:stylo_buddy/ViewModel/LoginAndSignUp.dart';
import 'package:stylo_buddy/ViewModel/DataProvider.dart';
import 'package:stylo_buddy/ViewModel/ThemeProvider.dart';
import 'package:stylo_buddy/ViewModel/TrendingData.dart';
import 'package:stylo_buddy/Views/AuthClass.dart';
import 'package:stylo_buddy/Views/GeneralPage.dart';
import 'package:stylo_buddy/Views/Homepage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stylo_buddy/Views/LoginPage.dart';
import 'package:stylo_buddy/Views/Profile.dart';
import 'package:stylo_buddy/Views/SplashScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(url: dotenv.get("supabaseUrl"), anonKey: dotenv.get("apikey"));



  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_)=>DataProvider()),
        ChangeNotifierProvider(create: (_)=>ThemeProvider()),
        ChangeNotifierProvider(create: (_)=>TrendingData()),
        ChangeNotifierProvider(create: (_)=>LoginAndSignUp())],child:const MyApp()));

}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeprovider=Provider.of<ThemeProvider>(context);


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme:themeprovider.currentTheme,
      home: Splashscreen(),
    );
  }
}

