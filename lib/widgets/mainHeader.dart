import 'package:flutter/material.dart';
import 'package:online_admission_result_checker_app/helpers/authentication.dart';
import 'package:online_admission_result_checker_app/models/user.dart';

BaseAuth auth = Auth();

signout(context) async {
  await auth.signOut();
  Navigator.pop(context);
}

AppBar mainHeader(context, {User user = null, bool isTitle = false, String title = ''}) {
  return AppBar(
    centerTitle: true,
    leading: Text(''),
    title: Text(user != null ? user.username : isTitle ? title : ''),
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
