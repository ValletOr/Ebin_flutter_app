import 'package:enplus_market/models/Account.dart';
import 'package:enplus_market/models/AppModel.dart';
import 'package:enplus_market/models/Company.dart';
import 'package:enplus_market/models/Review.dart';
import 'package:enplus_market/models/Role.dart';
import 'package:enplus_market/models/UserApp.dart';

class User{
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
  final List<AppModel>? apps;
  final List<UserApp>? userApps;
  final List<Review>? reviews;

  User({
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
    this.apps,
    this.userApps,
    this.reviews,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? '',
      lastName: json['lastName'] ?? '',
      middleName: json['middleName'] ?? '',
      status: json['status'] ?? '',
      phone: json['phone'] ?? '',
      roleId: json['roleId'] ?? 0,
      role: json['role'] != null ? Role.fromJson(json['role']) : null,
      companyId: json['companyId'] ?? 0,
      company: json['company'] != null ? Company.fromJson(json['company']) : null,
      account: json['account'] != null ? Account.fromJson(json['account']) : null,
      apps: (json['apps'] as List?)?.map((e) => AppModel.fromJson(e)).toList() ?? [],
      userApps: (json['userApps'] as List?)?.map((e) => UserApp.fromJson(e)).toList() ?? [],
      reviews: (json['reviews'] as List?)?.map((e) => Review.fromJson(e)).toList() ?? [],
    );
  }
}