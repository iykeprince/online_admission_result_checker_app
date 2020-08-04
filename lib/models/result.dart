import 'university.dart';
import 'user.dart';

class Result {
  String id;
  User user;
  University university;
  int score = 0;

  Result({this.user, this.university, this.score});

  factory Result.fromMap(Map<String, dynamic> snapshot) {
    Result result = Result();
    result.id = snapshot['id'];
    result.score = snapshot['score'];
    return result;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "score": score,
    };
  }
}
