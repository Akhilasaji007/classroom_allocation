class ClassRoom {
  final int id;
  final String name;
  final String layout;
  final int size;
  final String? subject;

  ClassRoom({
    required this.id,
    required this.name,
    required this.layout,
    required this.size,
    required this.subject,
  });

  factory ClassRoom.fromJson(Map<String, dynamic> json) {
    return ClassRoom(
      id: json['id'],
      name: json['name'],
      layout: json['layout'],
      size: json['size'],
      subject: json['subject'],
    );
  }
}
