class Book {

  int id;
  String name;
  int year;
  String author;
  String description;

  Book();

  void fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.year = map['year'];
    this.author = map['author'];
    this.description = map['description'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': this.name,
      'year': this.year,
      'author': this.author,
      'description': this.description
    };

    if (id != null) {
      map['id'] = this.id;
    }
    return map;
  }

}