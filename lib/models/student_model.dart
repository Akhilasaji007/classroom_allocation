class Student {
  final int id;
  final String name;
  final int age;
  final String email;

  Student({
    required this.id,
    required this.name,
    required this.age,
    required this.email,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      email: json['email'],
    );
  }
}
