import 'Company.dart';
import 'Role.dart';
import 'Account.dart';
import 'CardModel.dart';
import 'UserApp.dart';
import 'Review.dart';

class User {
  final int id;
  final String name;
  final String lastName;
  final String? middleName;
  final String status;
  final String phone;
  final int roleId;
  final Role? role;
  final int companyId;
  final Company? company;
  final Account? account;
  final List<CardModel> apps;
  final List<UserApp> userApps;
  final List<Review> reviews;

  User({
    required this.id,
    required this.name,
    required this.lastName,
    this.middleName,
    required this.status,
    required this.phone,
    required this.roleId,
    this.role,
    required this.companyId,
    this.company,
    this.account,
    this.apps = const [],
    this.userApps = const [],
    this.reviews = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      lastName: json['last_name'] ?? '',
      middleName: json['middle_name'],
      status: json['status'] ?? '',
      phone: json['phone'] ?? '',
      roleId: json['role_id'] ?? 0,
      companyId: json['company_id'] ?? 0,
    );
  }
}
