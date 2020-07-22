import 'package:flutter/material.dart';
import '../models/course.dart';

class GradeField extends StatefulWidget {
  GradeField({
    Key key,
    this.course,
  }) : super(key: key);
  Course course;

  @override
  _GradeFieldState createState() => _GradeFieldState();
}

class _GradeFieldState extends State<GradeField> {
  @override
  Widget build(BuildContext context) {
    return _addGradeField(widget.course);
  }

  String grade;
  final List<String> grades = [
    'A1',
    'B2',
    'B3',
    'C4',
    'C5',
    'C6',
    'D7',
    'E8',
    'F9'
  ];
  _addGradeField(Course course) {
    return Container(
      height: 50,
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButton(
        items: grades
            .map(
              (grade) => DropdownMenuItem(
                value: grade,
                child: Text(grade,
                    style: TextStyle(
                      fontSize: 16.0,
                    )),
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            grade = value;
            course.grade = value;
          });
        },
        value: grade,
        elevation: 10,
      ),
    );
  }
}
