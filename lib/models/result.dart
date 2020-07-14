import 'package:cloud_firestore/cloud_firestore.dart';

import 'university.dart';
import 'user.dart';

class Result {
  String id;
  User user;
  University university;
  int score = 0;

  Result({this.user, this.university, this.score});

  factory Result.fromDocument(DocumentSnapshot snapshot, String id) {
    Result result = Result();
    result.id = id;
    result.user = snapshot['user'];
    result.university = snapshot['university'];
    result.score = snapshot['score'];
    return result;
  }
}
