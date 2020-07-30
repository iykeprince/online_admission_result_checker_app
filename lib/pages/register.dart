import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../helpers/authentication.dart';
import '../models/user.dart';
import '../widgets/formField.dart';

import 'home.dart';

final BaseAuth _auth = Auth();
Firestore _firestore = Firestore.instance;
CollectionReference _ref = _firestore.collection('/users');

class Register extends StatefulWidget {
  static const String routeName = '/register';

  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();//initialize the global form key
  TextEditingController _usernameFieldController = TextEditingController();//initialize the username controller
  TextEditingController _regNumFieldController = TextEditingController();//initialize the reg number controller
  TextEditingController _emailFieldController = TextEditingController();//initialize the email controller
  TextEditingController _phoneFieldController = TextEditingController();//initialize the phone controller
  TextEditingController _passwordFieldController = TextEditingController();//initialize the password controller
  TextEditingController _confirmPasswordFieldController =
      TextEditingController();//initialize the confirm password controller

  String genderValue = '';//initialize the gender
  String errorMessage = '';//initialize error message
  bool isPassword = false;//initialize if is password or not

  Container _formButton() {//method for create custom form button
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: EdgeInsets.only(
        top: 16,
      ),
      child: RaisedButton(
        color: Theme.of(context).accentColor,
        onPressed: createAccount,
        child: Text(
          'Sign Up',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }

  //create account method
  createAccount() async {
    String email = _emailFieldController.text.trim();//get the value of email
    String password = _passwordFieldController.text;//get the value of password
    String username = _usernameFieldController.text;//get the value of username
    String phone = _phoneFieldController.text;//get the value of phone 
    String regNumber = _regNumFieldController.text;//get the value of reg number
    String confirmPassword = _confirmPasswordFieldController.text;//get the value confirm password

    if (password != confirmPassword) {
      print('retype password, passwords do not match');
      return;
    }

    try {
      String userId = await _auth.signUp(email, password);//get user id of current user
      //initialize and set user model 
      User user = User();
      user.userId = userId;
      user.username = username;
      user.email = email;
      user.phone = phone;
      user.regNumber = regNumber;
      user.gender = '';
      user.img = '';
      //store user model to firestore as profile
      await _ref.document(userId).setData(user.toJson());
      // Navigator.pop(context, 'Account was successfully created');
      FirebaseUser firebaseUser = await _auth.getCurrentUser();//get the current user
      print('Response: $user');
      DocumentSnapshot doc =
          await _firestore.document('/users/${firebaseUser.uid}').get();
  //navigate to home and passing user object 
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Home(user: User.fromDocument(doc.data, doc.documentID))),
      );
    } catch (e) {//catches errors
      setState(() {
        errorMessage = e.message;
      });
      print('Error: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {//build method contains codes for UI creation
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
        ),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 45.0,
                  left: 16.0,
                ),
                child: Text(
                  'Create Your Account',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  left: 16.0,
                ),
                child: Text(
                  'All fields are required',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
              errorMessage != ''
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        errorMessage,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.red,
                        ),
                      ),
                    )
                  : Text(''),
              Container(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          formField(
                              controller: _regNumFieldController,
                              text: 'Enter JAMB Registration number',
                              validationText:
                                  'Please enter your JAMB registration number',
                              icon: Icon(Icons.list),
                              value: _regNumFieldController.text, 
                            ),
                          formField(
                            controller: _usernameFieldController,
                            text: 'Username',
                            validationText: 'Please enter a valid username',
                            icon: Icon(Icons.email),
                            value: _usernameFieldController.text,
                          ),
                          formField(
                            controller: _emailFieldController,
                            text: 'Email Address',
                            validationText: 'Please enter a valid email',
                            icon: Icon(Icons.email),
                            value: _emailFieldController.text,
                          ),
                          formField(
                            controller: _phoneFieldController,
                            text: 'Phone Number',
                            validationText: 'Please enter a valid phone number',
                            icon: Icon(Icons.phone),
                            value: _phoneFieldController.text,
                          ),
                          Row(children: <Widget>[
                            // Expanded(
                            //   child: DropdownButton<String>(
                            //     hint: Text('Gender'),
                            //     value: genderValue,
                            //     items: <String>['', 'Male', 'Female', 'Others']
                            //         .map<DropdownMenuItem<String>>((String value) {
                            //       return DropdownMenuItem<String>(
                            //         value: value,
                            //         child: Text(value),
                            //       );
                            //     }).toList(),
                            //   ),
                            // ),
                          ]),
                          formField(
                            controller: _passwordFieldController,
                            text: 'Password',
                            validationText: 'Please enter a valid password',
                            icon: Icon(Icons.security),
                            isPassword: true,
                            value: _passwordFieldController.text,
                          ),
                          formField(
                              controller: _confirmPasswordFieldController,
                              text: 'Confirm Password',
                              validationText: 'Please enter confirm password',
                              icon: Icon(Icons.security),
                              isPassword: true,
                             value: _confirmPasswordFieldController.text,
                          ),
                          _formButton(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
