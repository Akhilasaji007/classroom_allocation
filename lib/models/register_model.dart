class Register {
  final int id;
  final int student;
  final int subject;

  Register({
    required this.id,
    required this.student,
    required this.subject,
  });

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      id: json['id'],
      student: json['student'],
      subject: json['subject'],
    );
  }
}
