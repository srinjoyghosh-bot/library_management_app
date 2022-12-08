class Borrow {
  int id, studentId, bookId;
  String createdAt;
  String? returnDate;

  Borrow({
    required this.id,
    required this.studentId,
    required this.bookId,
    required this.createdAt,
    required this.returnDate,
  });

  factory Borrow.fromJson(Map<String, dynamic> json) => Borrow(
        id: json['id'],
        studentId: json['student_id'],
        bookId: json['book_id'],
        createdAt: json['createdAt'],
        returnDate: json['return_date'],
      );
}
