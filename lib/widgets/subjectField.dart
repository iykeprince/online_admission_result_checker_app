import 'package:flutter/material.dart';
import '../models/course.dart';

class SubjectField extends StatefulWidget {
  SubjectField({
    Key key,
    this.course,
  }) : super(key: key);
  Course course;
  @override
  _SubjectFieldState createState() => _SubjectFieldState();
}

class _SubjectFieldState extends State<SubjectField> {
  List<String> subjects;
  String subject;

  @override
  void initState() {
    subjects = [
      'ARABIC',
      'AGRICULTURAL SCIENCE',
      'BIOLOGY',
      'COMPUTER STUDIES',
      'COMMERCE',
      'CLOTHING AND TEXTILES',
      'CLERICAL OFFICE DUTIES',
      'CIVIC EDUCATION',
      'CHRISTIAN RELIGIOUS STUDIES',
      'CHEMISTRY',
      'CERAMICS',
      'CATERING CRAFT PRACTICE',
      'CAPENTRY AND JOINERY',
      'DYEING & BLEACHING',
      'DATA PROCESSING',
      'ENGLISH LANGUAGE',
      'FINANCIAL ACCOUNTING',
      'SOCIAL STUDIES',
      'PHYSICS',
      'PHYSICAL EDUCATION',
      'OFFICE PRACTICE',
      'MUSIC',
      'MARKETING',
      'ISLAMIC RELIGIOUS STUDIES',
      'INTEGRATED SCIENCE',
      'INFORMATION AND COMMUNICATION TECHNOLOGY',
      'IGBO',
      'GEOGRAPHY'
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _addSubjectField(widget.course);
  }

  _addSubjectField(Course course) {
    return Container(
      width: 250,
      height: 50,
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: FittedBox(
        fit: BoxFit.fill,
        child: DropdownButton( 
          isDense: true,         
          items: subjects
              .map(
                (subject) => DropdownMenuItem(
                  value: subject,
                  child: Text(subject, style: TextStyle(
                    fontSize: 13
                  ),)),
              )
              .toList(),
          onChanged: (value) {
             print('selected subject: $value');
            setState(() {
              subject = value;
              course.subject = value;
            });
          },
          value: subject,
          hint: Text('select subject'),
        ),
      ),
    );
  }
}
