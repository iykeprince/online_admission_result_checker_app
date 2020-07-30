//importing material package
import 'package:flutter/material.dart';
//importing firebase auth module
import 'package:firebase_auth/firebase_auth.dart';
//importing all screen 
import 'pages/create-application.dart';
import 'pages/application-detail.dart';
import 'pages/admission-portal.dart';
import 'pages/forgot-password.dart';
import 'pages/home.dart';
import 'pages/login.dart';
import 'pages/register.dart';
import 'pages/result-checker.dart';
import 'pages/verify-cutoff.dart';
import 'pages/welcome.dart';

void main() {//main method that bootstrap the whole application or this is the entry point of the app.
  runApp(MyApp());
}
//this method is checking if the user exists, if they exists it will return a firebaseUser object otherwise null.
getCurrentUser() async {
  FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
  return currentUser;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(//material wrapper for the whole app
      title: 'Burkman App',//title of the app
      initialRoute: Welcome.routeName,//this specifies the first screen to show when the app starts
      routes: {//list of all the screen navigation our app has.
        Welcome.routeName: (context) => Welcome(),
        Login.routeName: (context) => Login(),
        Register.routeName: (context) => Register(),
        ForgotPassword.routeName: (context) => ForgotPassword(),
        Home.routeName: (context) => Home(),
        AdmissionPortal.routeName: (context) => AdmissionPortal(),
        ResultChecker.routeName: (context) => ResultChecker(),
        VerifyCutOff.routeName: (context) => VerifyCutOff(),
        CreateApplication.routeName: (context) => CreateApplication(),
        ApplicationDetail.routeName: (context) => ApplicationDetail(),
      },
      theme: ThemeData(//setting the theme colors for the app
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,//this will remove the debug flag on the appbar of the app.
      home: Welcome(), //screen to load
    );
  }
}
