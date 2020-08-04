import 'course.dart';
import 'entry.dart';
import 'result.dart';
import 'university.dart';
import 'user.dart';

class AppModel {
  String id;

  University university;
  User user;
  List<Course> courses;
  Result result;
  List<Entry> entries;

  AppModel({
    this.id,
    this.university,
    this.user,
    this.courses,
    this.result,
    this.entries,
  });

  factory AppModel.fromMap(Map<String, dynamic> snapshot, String id) {
    // print('inside application model: ${snapshot['university']}');
    print('snapshot: ${snapshot['user']}');
    AppModel application = new AppModel(
      id: id,
      university: University.fromMap(snapshot['university']),
      result: Result.fromMap(snapshot['result']),
      // entries: List.from((element) => Entry.fromMap(snapshot['entries'], snapshot['entries']['id'])),
      user: User.fromMap(snapshot['user'], snapshot['user']['user_id'])
    );
    // application.id = id;

    // application.university = University.fromMap(snapshot.);

    // application.user = User.fromMap(
    //   snapshot['user'],
    //   snapshot['user']['user_id'],
    // );

    // application.entries = List<Entry>.from(
    //   snapshot['entries'].map((entry) {
    //     Entry.fromMap(
    //       entry,
    //       '09909090',
    //     );
    //     print('entry: ${entry.toString()}');
    //   }),
    // );

    // application.result = Result.fromMap(
    //   snapshot['result'],
    // );
    return application;
  }

  Map<String, dynamic> toJson() {
    return {
      "university": university.toMap(),
      "user": user.toMap(),
      "result": result.toMap(),
      "entries": entries.map((entry) => entry.toMap()).toList(),
    };
  }
}
