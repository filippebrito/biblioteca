class Book { 
  int id;
  String name;
  String image;
  
  Book({this.id, this.name, this.image});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      name: json['name'],
      image: checkImage(json['image']),
    );
  }

  Book.fromMap(Map<String, Object> map) {
    id = map["id"];
    name = map["name"];
    image = checkImage(map["image"]);
  }

  static String checkImage(String image){
    if(image == null ){
      return "images/book-placeholder.png";
    }
    return image;
  }

}