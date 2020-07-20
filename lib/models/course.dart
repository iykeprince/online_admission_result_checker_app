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

  factory Course.fromDocument(DocumentSnapshot snapshot, String id) {
    Course course = Course();
    course.id = snapshot['id'];
    course.subject = snapshot['subject'];
    course.score = snapshot['score'];
    course.grade = snapshot['grade'];
    return course;
  }

  @override
  String toString() {
    return '{subject: $subject, score: $score, grade: $grade}';
  }
}
