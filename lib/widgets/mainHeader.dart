import 'package:flutter/material.dart';
import 'package:online_admission_result_checker_app/helpers/authentication.dart';
import 'package:online_admission_result_checker_app/helpers/user.dart';

BaseAuth auth = Auth();

signout(context) async {
  await auth.signOut();
  Navigator.pop(context);
}

AppBar mainHeader(context, User user) {
  return AppBar(
    leading: Padding(
      padding: const EdgeInsets.all(12.0),
      child: CircleAvatar(
        backgroundColor: Colors.blueAccent,
      ),
    ),
    title: Text(user != null ? user.username : ''),
    actions: <Widget>[
      FlatButton(
        child: Text(
          'Logout',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () => signout(context),
      )
    ],
  );
}
