import 'course.dart';

class Entry {
  int entryIndex = 0;
  String id;
  String name;
  List<Course> courses;

  Entry({this.entryIndex, this.name, this.courses});

  factory Entry.fromMap(Map<String, dynamic> snapshot, String id) {
    print('entries snapshot $snapshot');
    Entry entry = new Entry();
    entry.id = id;
    entry.name = snapshot['name'];
    entry.courses = List.from(
      snapshot['courses'].map(
        (course) => Course.fromMap(course),
      ),
    );
    return entry;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'courses': courses.map((course) => course.toMap()).toList(),
    };
  }

  @override
  String toString() {
    return 'entry: index $entryIndex, name: $name, courses: $courses';
  }
}
