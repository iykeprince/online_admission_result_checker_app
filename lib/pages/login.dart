//import firebase auth and firestore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//importing material package
import 'package:flutter/material.dart';
//the firebase auth helper
import '../helpers/authentication.dart';
//importing user model
import '../models/user.dart';
//import screens to navigate
import '../pages/forgot-password.dart';
import '../pages/home.dart';
import '../pages/register.dart';
//importing custom formField widget
import '../widgets/formField.dart';

BaseAuth _auth = Auth();//initialize the auth base class
Firestore _firestore = Firestore.instance;//initialze firestore

class Login extends StatefulWidget {
  static const String routeName = '/login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isAuthenticating = false; //initialize setting for isAuthenticating
  final _formKey = GlobalKey<FormState>(); //initializeglobal form key 
  TextEditingController _emailFieldController = TextEditingController();//initialize controller for email
  TextEditingController _passwordFieldController = TextEditingController();//initialize controller for password

  String errorMessage = ''; //initialize variable for reading errors

  @override
  void initState() {
    super.initState();
  }
  //method to navigate to create account screen
  void _createAccount(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Register()),
    );
  }
  //method for custom button
  Container _formButton({Function onPressed, String text}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: EdgeInsets.only(
        top: 16,
      ),
      child: RaisedButton(
        color: Theme.of(context).accentColor,
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
  //method for logging in
  login() async {
    setState(() {
      isAuthenticating = true; //set the isAuthenticating to true to show progress
    });
    String email = _emailFieldController.text.trim();//get the value of email
    String password = _passwordFieldController.text;//get the value of password

  //validating the form
    if (_formKey.currentState.validate()) {//if validate
      print('signing in...');
      try {
        String response = await _auth.signIn(email, password);//call firebase auth
        FirebaseUser user = await _auth.getCurrentUser();//get the current user
        print('Response: $response uid $user');
        DocumentSnapshot doc =
            await _firestore.document('/users/${user.uid}').get();//get the user profile
        print('data ${doc.data}');
        await Navigator.push(//navigate to home screen
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Home(user: User.fromDocument(doc.data, doc.documentID))),
        );
        setState(() {
          isAuthenticating = false;//set the isAuthenticating to false, to hide progress
        });
      } catch (e) {//catch clause to handle errors encountered while performing operations
        print('Error: $e');
        setState(() {
          isAuthenticating = false;
          errorMessage = e.message;
        });
      }
    } else {//if validation fails
      print('validation required');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: ListView(children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Login',
                      style: TextStyle(fontSize: 42),
                    ),
                    Text(
                      errorMessage,
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      formField(
                        controller: _emailFieldController,
                        text: 'Email',
                        validationText: 'Please enter a valid email',
                        icon: Icon(Icons.account_circle),
                        value: _emailFieldController.text,
                      ),
                      formField(
                        controller: _passwordFieldController,
                        text: 'Password',
                        validationText: 'Please enter a valid password',
                        icon: Icon(Icons.security),
                        value: _passwordFieldController.text,
                        isPassword: true,
                      ),
                      _formButton(onPressed: login, text: 'Sign In'),
                    ],
                  ),
                ),
              ),
              isAuthenticating
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Text(''),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                      child: Text('Reset Password'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()),
                        );
                      }),
                  FlatButton(
                    child: Text('Create an account'),
                    onPressed: () => _createAccount(context),
                  ),
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }
}
