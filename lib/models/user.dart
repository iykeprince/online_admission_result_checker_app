import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String userId;
  String regNumber;
  String username;
  String email;
  String phone;
  String gender;
  String img;

  User(
      {this.userId,
      this.regNumber,
      this.username,
      this.email,
      this.gender,
      this.img});

  factory User.fromMap(Map snapshot, String id) {
    print('snapshot user: $snapshot');
    User user = User();
    user.userId = id;
    user.username = snapshot['username'];
    user.email = snapshot['email'];
    user.gender = snapshot['gender'];
    user.regNumber = snapshot['reg_number'];
    return user;
  }

  toJson() {
    return {
      "user_id": userId,
      "username": username,
      "email": email,
      "phone": phone,
      "reg_number": regNumber,
      "gender": gender,
      "img": img,
    };
  }
}
