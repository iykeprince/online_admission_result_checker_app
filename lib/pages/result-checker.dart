import 'package:flutter/material.dart';
import 'package:online_admission_result_checker_app/pages/verify-cutoff.dart';

class ResultChecker extends StatefulWidget {
  static const String routeName = '/resultChecker';

  ResultChecker({Key key}) : super(key: key);

  @override
  _ResultCheckerState createState() => _ResultCheckerState();
}

class _ResultCheckerState extends State<ResultChecker> {
  final TextEditingController _matricFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(50),
              ),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 40, bottom: 4),
                      alignment: Alignment.centerLeft,
                      child: Text('Enter your matriculation number'),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Matric Number',
                      ),
                      controller: _matricFieldController,
                      keyboardType: TextInputType.text,
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => VerifyCutOff(),)
                        );
                      },
                      child: Text('View Application'),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
