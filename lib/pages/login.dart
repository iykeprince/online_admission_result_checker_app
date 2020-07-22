import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../helpers/authentication.dart';
import '../models/user.dart';
import '../pages/forgot-password.dart';
import '../pages/home.dart';
import '../pages/register.dart';
import '../widgets/formField.dart';

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

  String errorMessage = ''; 

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
              builder: (context) =>
                  Home(user: User.fromDocument(doc.data, doc.documentID))),
        );
        setState(() {
          isAuthenticating = false;
        });
      } catch (e) {
        print('Error: $e');
        setState(() {
          isAuthenticating = false;
          errorMessage = e.message;
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
