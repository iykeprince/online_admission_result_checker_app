import 'package:flutter/material.dart';

class ApplicationReview extends StatefulWidget {
  ApplicationReview({Key key}) : super(key: key);

  @override
  _ApplicationReviewState createState() => _ApplicationReviewState();
}

class _ApplicationReviewState extends State<ApplicationReview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[],
            ),
          ),
          Divider(),
          Container(
            child: Column(
              children: <Widget>[],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RaisedButton(
                onPressed: () {},
                child: Text('Back'),
              ),
              RaisedButton(
                onPressed: () {},
                child: Text('Submit'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
