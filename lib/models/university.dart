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

  factory University.fromDocument(Map<String, dynamic> doc, String id) {
    University university = University();
    university.id = id;
    university.name = doc['name'];
    university.accronym = doc['accronym'];
    university.founded = doc['founded'];
    university.image = doc['image'];
    return university;
  }

  toJson() {
    return {
      'id': id,
      'name': name,
      'accronym': accronym,
      'founded': founded,
      'image': image,
    };
  }
}
