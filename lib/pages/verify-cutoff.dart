import 'package:flutter/material.dart';
import 'package:online_admission_result_checker_app/models/result.dart';

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
                        fontSize: 20,
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
                            fontSize: 14.0,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                        ),
                        Text(
                          '${result.user.email}',
                          style: TextStyle(
                            fontSize: 14.0,
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
                            fontSize: 14.0,
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
                            fontSize: 14.0,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Container(
                      child: FlatButton(
                        child: Text('Apply'),
                        onPressed: () {
                          print('applying...');
                        },
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
    Result result = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('2019/2020 Jamb Result'),
      ),
      body: _buildResultScreen(result: result),
    );
  }
}
