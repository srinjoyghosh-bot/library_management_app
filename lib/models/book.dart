class Book {
  int id;
  String name, description, publisher, author;
  String? imageUrl;
  bool available;

  Book({
    required this.id,
    required this.name,
    required this.description,
    required this.publisher,
    required this.author,
    this.imageUrl,
    required this.available,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        publisher: json['publisher'],
        author: json['author'],
        available: json['available'],
        imageUrl: json['imageUrl'],
      );
}
