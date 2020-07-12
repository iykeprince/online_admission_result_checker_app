import 'package:flutter/material.dart';

import 'pages/admission-portal.dart';
import 'pages/forgot-password.dart';
import 'pages/home.dart';
import 'pages/login.dart';
import 'pages/register.dart';
import 'pages/result-checker.dart';
import 'pages/verify-cutoff.dart';
import 'pages/welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Burkman App',
      initialRoute: Welcome.routeName,
      routes: {
        Welcome.routeName: (context) => Welcome(),
        Login.routeName: (context) => Login(),
        Register.routeName: (context) => Register(),
        ForgotPassword.routeName: (context) => ForgotPassword(),
        Home.routeName: (context) => Home(),
        AdmissionPortal.routeName: (context) => AdmissionPortal(),
        ResultChecker.routeName: (context) => ResultChecker(),
        VerifyCutOff.routeName: (context) => VerifyCutOff(),
      },
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: Welcome(title: 'BurkMan'),
    );
  }
}

