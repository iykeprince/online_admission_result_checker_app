import 'package:flutter/material.dart';

Widget mainBody() {
  return Padding(
    padding: const EdgeInsets.only(top: 60, bottom: 40, left: 10, right: 10),
    child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Welcome',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'John Smith',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          Expanded(
            child: Container(
              child: Text(''),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: RaisedButton(
                  padding: const EdgeInsets.all(20),
                  onPressed: (){},
                  child: Text('Admission Portal'),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(4),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: RaisedButton(
                  padding: const EdgeInsets.all(20),
                  onPressed: (){},
                  child: Text('Result Checker'),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
