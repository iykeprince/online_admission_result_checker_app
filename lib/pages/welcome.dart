import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../helpers/authentication.dart';
import '../models/user.dart';

import 'home.dart';
import 'login.dart';
import 'register.dart';

BaseAuth _auth = Auth();
Firestore _firestore = Firestore.instance;

class Welcome extends StatefulWidget {
  Welcome({Key key, this.title}) : super(key: key);
  final String title;
  static const String routeName = '/welcome';
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    _auth.getCurrentUser().then((value) => print('firebase user $value'));
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

  void _openHome(context) async {
    FirebaseUser user = await _auth.getCurrentUser();
        print('uid $user');
        DocumentSnapshot doc =
            await _firestore.document('/users/${user.uid}').get();
        print('data ${doc.data}');
        await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Home(user: User.fromDocument(doc.data, doc.documentID))),
        );
  }

  @override
  Widget build(BuildContext context) {
    return buildWelcome(context);
  }

  buildWelcome(context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        child: FutureBuilder(
          future: _auth.getCurrentUser(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Column(
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
              );
            } else {
              return Column(
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
                  Text(
                    'You are already logged in',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    width: 350,
                    height: 60,
                    child: FlatButton.icon(
                      onPressed: () => _openHome(context),
                      icon: Icon(
                        Icons.account_circle,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Open Home',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
  /*   */
}
