//importing material package
import 'package:flutter/material.dart';
//importing the login screen
import '../pages/login.dart';

class ForgotPassword extends StatefulWidget {
  static const String routeName = '/forgotPassword';

  ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();//initialize the global key
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: FittedBox(
                  child: Text(
                    'Reset Password',
                    style: TextStyle(fontSize: 42),
                  ),
                ),
              ),
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          icon: Icon(Icons.email),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              print('resetting password...');
                            }
                          },
                          child: Text('Reset password'),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: Text('Login'),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
