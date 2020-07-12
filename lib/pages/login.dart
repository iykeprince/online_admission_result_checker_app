import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_admission_result_checker_app/helpers/authentication.dart';
import 'package:online_admission_result_checker_app/helpers/user.dart';
import 'package:online_admission_result_checker_app/pages/forgot-password.dart';
import 'package:online_admission_result_checker_app/pages/home.dart';
import 'package:online_admission_result_checker_app/pages/register.dart';

BaseAuth _auth = Auth();
Firestore _firestore = Firestore.instance;

class Login extends StatefulWidget {
  static const String routeName = '/login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isAuthenticating = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailFieldController = TextEditingController();
  TextEditingController _passwordFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _createAccount(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Register()),
    );
  }

  Container _formField(
      {TextEditingController controller,
      String text,
      String validationText,
      Icon icon}) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
      ),
      padding: EdgeInsets.only(
        left: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: controller,
        style: TextStyle(
          fontSize: 16.0,
        ),
        decoration: InputDecoration(
          hintText: text,
          icon: icon,
          border: InputBorder.none,
        ),
        validator: (value) {
          if (value.isEmpty) {
            return validationText;
          }
          return null;
        },
      ),
    );
  }

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

  login() async {
    setState(() {
      isAuthenticating = true;
    });
    String email = _emailFieldController.text.trim();
    String password = _passwordFieldController.text;

    if (_formKey.currentState.validate()) {
      print('signing in...');
      try {
        String response = await _auth.signIn(email, password);
        FirebaseUser user = await _auth.getCurrentUser();
        print('Response: $response uid $user');
        DocumentSnapshot doc =
          await _firestore.document('/users/${user.uid}').get();
        print('data ${doc.data}');
        await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Home(user: User.fromMap(doc.data))),
        );
        setState(() {
          isAuthenticating = false;
        });
      } catch (e) {
        print('Error: $e');
        setState(() {
          isAuthenticating = false;
        });
      }
    } else {
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
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 42),
                ),
              ),
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      _formField(
                        controller: _emailFieldController,
                        text: 'Email',
                        validationText: 'Please enter a valid email',
                        icon: Icon(Icons.account_circle),
                      ),
                      _formField(
                        controller: _passwordFieldController,
                        text: 'Password',
                        validationText: 'Please enter a valid password',
                        icon: Icon(Icons.security),
                      ),
                      _formButton(onPressed: login, text: 'Sign In'),
                    ],
                  ),
                ),
              ),
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
