import 'package:cloud_firestore/cloud_firestore.dart';

import 'course.dart';
import 'result.dart';
import 'university.dart';
import 'user.dart';

class Application {
  String id;

  University university;
  User user;
  List<Course> courses;
  Result result;

  Application({
    this.university,
    this.user,
    this.courses,
    this.result,
  });

  factory Application.fromDocument(DocumentSnapshot snapshot, String id) {
    Application application = new Application();
    application.id = id;
    application.university = University.fromDocument(
        snapshot['university'], snapshot['university'].university_id);
    application.user =
        User.fromDocument(snapshot['user'], snapshot['user'].user_id);
    application.result =
        Result.fromDocument(snapshot['result'], snapshot['result'].result_id);
    application.courses = List<Course>.from(snapshot['courses']
        .map((course) => Course.fromDocument(course, course.course_id)));
    return application;
  }
}
