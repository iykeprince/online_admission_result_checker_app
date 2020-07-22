import 'course.dart';

class Entry {
  int entryIndex = 0;
  String name;
  List<Course> courses;

  Entry({this.entryIndex, this.name, this.courses});

  @override
  String toString() {
    return 'entry: index $entryIndex, name: $name, courses: $courses';
  }
}
