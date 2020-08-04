class University {
  String id;
  String name;
  String accronym;
  String image;
  String founded;

  University({
    this.id,
    this.name,
    this.accronym,
    this.image,
    this.founded,
  });

  factory University.fromMap(Map<String, dynamic> doc) {
    University university = University();
    university.id = doc['id'];
    university.name = doc['name'];
    university.accronym = doc['accronym'];
    university.founded = doc['founded'];
    university.image = doc['image'];
    return university;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'accronym': accronym,
      'founded': founded,
      'image': image,
    };
  }
}
