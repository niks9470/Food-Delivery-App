import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:zwiggy/admin/add_food.dart';
import 'package:zwiggy/admin/admin_login.dart';
import 'package:zwiggy/admin/home_admin.dart';
import 'package:zwiggy/pages/bottomNav.dart';
import 'package:zwiggy/pages/forgotpassword.dart';
import 'package:zwiggy/pages/homePage.dart';
import 'package:zwiggy/pages/loginPage.dart';
import 'package:zwiggy/pages/onboard.dart';
import 'package:zwiggy/pages/profile.dart';
import 'package:zwiggy/pages/signupPage.dart';
import 'package:zwiggy/widget/app_constant.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey= publishableKey;
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Onboard(),
    );
  }
}
