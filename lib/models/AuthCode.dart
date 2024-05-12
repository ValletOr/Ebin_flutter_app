class AuthCode {
  final String phone;
  final String code;

  AuthCode({
    required this.phone,
    required this.code,
  });

  factory AuthCode.fromJson(Map<String, dynamic> json) {
    return AuthCode(
      phone: json['phone'] ?? '',
      code: json['code'] ?? '',
    );
  }
}
