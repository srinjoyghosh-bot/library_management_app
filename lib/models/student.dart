class Student {
  String enrollmentId, year;
  String name, branch, degree;
  String? imageUrl;

  Student({
    required this.enrollmentId,
    required this.year,
    required this.name,
    required this.branch,
    required this.degree,
    this.imageUrl,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
      enrollmentId: json['enrollment_id'].toString(),
      year: json['year'].toString(),
      name: json['name'],
      branch: json['branch'],
      degree: json['degree'],
      imageUrl: json['image_url']);
}
