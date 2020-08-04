
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

  factory User.fromMap(Map<String, dynamic> snapshot, String id) {
    User user = User();
    user.userId = id;
    user.username = snapshot['username'];
    user.email = snapshot['email'];
    user.gender = snapshot['gender'];
    user.regNumber = snapshot['reg_number'];
    user.phone = snapshot['phone'];
    return user;
  }

  Map<String, dynamic> toMap() {
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
