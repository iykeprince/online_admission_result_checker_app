import 'package:flutter/material.dart';
import '../models/result.dart';

import 'create-application.dart';

class VerifyCutOff extends StatefulWidget {
  static const String routeName = '/verifyCutOff';

  VerifyCutOff({
    Key key,
  }) : super(key: key);

  @override
  _VerifyCutOffState createState() => _VerifyCutOffState();
}

class _VerifyCutOffState extends State<VerifyCutOff> {
  @override
  void initState() {
    super.initState();
  }

  //method to show result screen
  _buildResultScreen({Result result}) {
    return result == null
        ? Column(
            children: <Widget>[
              Text('No Result available!'),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Go Back Home'),
              ),
            ],
          )
        : ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Score',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '${result.score}',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),
                    Text(
                      'University',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '${result.university.name}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Name',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                        ),
                        Text(
                          '${result.user.username}',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                        ),
                        Text(
                          '${result.user.email}',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Phone',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                        ),
                        Text(
                          '${result.user.phone}',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Registration No.',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                        ),
                        Text(
                          '${result.user.regNumber}',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(),
                    ),
                    result.score > 180
                        ? Align(
                            alignment: Alignment.center,
                            child: RaisedButton(
                              child: Text(
                                'Apply',
                              ),
                              color: Theme.of(context).accentColor,
                              onPressed: () {
                                print('applying...');
                                Navigator.pushNamed(
                                    context, CreateApplication.routeName,
                                    arguments: result);
                              },
                            ),
                          )
                        : Container(
                            child: Center(
                              child: Text(
                                  'Sorry but your score didn\'t meet with the university cut-off, you are applying for. Please try again some other time.',
                                  style: TextStyle(color: Colors.red, fontSize: 18.0, ),),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    Result result = ModalRoute.of(context).settings.arguments;//read from passed navigator argument
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('2019/2020 Jamb Result'),
      ),
      body: _buildResultScreen(result: result),
    );
  }
}
