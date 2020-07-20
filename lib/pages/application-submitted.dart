import 'package:flutter/material.dart';

class ApplicationSubmitted extends StatefulWidget {
  ApplicationSubmitted({Key key}) : super(key: key);

  @override
  _ApplicationSubmittedState createState() => _ApplicationSubmittedState();
}

class _ApplicationSubmittedState extends State<ApplicationSubmitted> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.check_circle_outline,
            size: 120.0,
          ),
          Text(
            'Application submitted',
            style: TextStyle(
              fontSize: 36.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          GestureDetector(
            onTap: () {
              print('on finished');
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8.0,
                      color: Colors.grey,
                    ),
                  ]),
              child: Text('Finish'),
            ),
          )
        ],
      ),
    );
  }
}
