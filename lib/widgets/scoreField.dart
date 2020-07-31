import 'package:Burkman/models/course.dart';
import 'package:flutter/material.dart';

class ScoreField extends StatefulWidget {
  ScoreField({
    Key key,
    this.course,
  }) : super(key: key);
  final Course course;
  @override
  _ScoreFieldState createState() => _ScoreFieldState();
}

class _ScoreFieldState extends State<ScoreField> {
  String score;
  @override
  Widget build(BuildContext context) {
    return _addScoreField(widget.course);
  }

  //method for generating score field
  _addScoreField(Course course) {
    TextEditingController controller = TextEditingController();
    controller.text = score;
    print('score controller $score');
    return Container(
      width: 70,
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10)),
        onChanged: (value) {
          print('new value $value');
          score = value;
          widget.course.score = score;
          setState(() {
            widget.course.score = score;
          });
        },
        controller: controller,
        keyboardType: TextInputType.text,
      ),
    );
  }
}
