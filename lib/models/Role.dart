class Role {
  final String Name;


  Role({
    required this.Name,

  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      Name: json['Name'] ?? '',
    );
  }
}
