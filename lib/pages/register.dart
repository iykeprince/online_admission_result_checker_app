import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_admission_result_checker_app/helpers/authentication.dart';
import 'package:online_admission_result_checker_app/models/user.dart';
import 'package:online_admission_result_checker_app/widgets/formField.dart';

import 'home.dart';

final BaseAuth _auth = Auth();
CollectionReference _ref = Firestore.instance.collection('/users');

class Register extends StatefulWidget {
  static const String routeName = '/register';

  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameFieldController = TextEditingController();
  TextEditingController _regNumFieldController = TextEditingController();
  TextEditingController _emailFieldController = TextEditingController();
  TextEditingController _phoneFieldController = TextEditingController();
  TextEditingController _passwordFieldController = TextEditingController();
  TextEditingController _confirmPasswordFieldController =
      TextEditingController();

  String genderValue = '';
  String errorMessage = '';

  

  Container _formButton() {
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

  createAccount() async {
    String email = _emailFieldController.text.trim();
    String password = _passwordFieldController.text;
    String username = _usernameFieldController.text;
    String phone = _phoneFieldController.text;
    String regNumber = _regNumFieldController.text;
    String confirmPassword = _confirmPasswordFieldController.text;

    if (password != confirmPassword) {
      print('retype password, passwords do not match');
      return;
    }

    try {
      String userId = await _auth.signUp(email, password);

      User user = User();
      user.userId = userId;
      user.username = username;
      user.email = email;
      user.phone = phone;
      user.regNumber = regNumber;
      user.gender = '';
      user.img = '';

      await _ref.document(userId).setData(user.toJson());
      // Navigator.pop(context, 'Account was successfully created');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } catch (e) {
      setState(() {
        errorMessage = e.message;
      });
      print('Error: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                              icon: Icon(Icons.list)),
                          formField(
                            controller: _usernameFieldController,
                            text: 'Username',
                            validationText: 'Please enter a valid username',
                            icon: Icon(Icons.email),
                          ),
                          formField(
                            controller: _emailFieldController,
                            text: 'Email Address',
                            validationText: 'Please enter a valid email',
                            icon: Icon(Icons.email),
                          ),
                          formField(
                            controller: _phoneFieldController,
                            text: 'Phone Number',
                            validationText: 'Please enter a valid phone number',
                            icon: Icon(Icons.phone),
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
                          ),
                          formField(
                            controller: _confirmPasswordFieldController,
                            text: 'Confirm Password',
                            validationText: 'Please enter confirm password',
                            icon: Icon(Icons.security),
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
