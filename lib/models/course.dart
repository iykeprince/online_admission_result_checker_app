import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  String id;
  String subject;
  String score;
  String grade;

  Course({
    this.subject,
    this.score,
    this.grade,
  });


  factory Course.fromMap(Map<String, dynamic> map) {
    Course course = Course();
    course.id = map['id'];
    course.subject = map['subject'];
    course.score = map['score'];
    course.grade = map['grade'];
    return course;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subject': subject,
      'score': score,
      'grade': grade,
    };
  }

  @override
  String toString() {
    return '{subject: $subject, score: $score, grade: $grade}';
  }
}
