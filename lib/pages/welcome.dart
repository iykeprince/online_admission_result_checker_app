import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'login.dart';
import 'register.dart';

class Welcome extends StatefulWidget {
  Welcome({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  static const String routeName = '/welcome';
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((value) {
      print('value $value');
      if (value != null) {
        Home();
      } else {
        Login();
      }
    });
    super.initState();
  }

  void _signIn(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  void _createAccount(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Register()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: buildWelcome(context));
  }

  buildWelcome(context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Burkman',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Signatra",
              fontSize: 74,
              color: Colors.white,
            ),
          ),

          // Container(
          //   width: 140,
          //   height: 140,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(50),
          //     border: Border.all(color: Colors.amber, width: 2),
          //   ),
          // ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            width: 350,
            height: 60,
            child: FlatButton.icon(
              onPressed: () => _signIn(context),
              icon: Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
              label: Text(
                'Sign in',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10),
              color: Theme.of(context).accentColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'I don\'t have an account?   ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                InkWell(
                  onTap: () => _createAccount(context),
                  child: Text(
                    'Create an account',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
