class Book {
  int id;
  String name;
  
  Book({this.id, this.name});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      name: json['name'],
    );
  }

  Book.fromMap(Map<String, Object> map) {
    id = map["id"];
    name = map["name"];
  }

}