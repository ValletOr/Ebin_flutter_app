


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
      name: json['Name'] ?? '',
      lastName: json['LastName'] ?? '',
      middleName: json['MiddleName'],
      status: json['Status'] ?? '',
      phone: json['Phone'] ?? '',
      roleId: json['RoleId'] ?? 0,
      role: json['Role'] != null ? Role.fromJson(json['Role']) : null,
      companyId: json['CompanyId'] ?? 0,
      company: json['Company'] != null ? Company.fromJson(json['Company']) : null,
      account: json['Account'] != null ? Account.fromJson(json['Account']) : null,
      apps: (json['Apps'] as List?)?.map((e) => AppModel.fromJson(e)).toList() ?? [],
      userApps: (json['UserApps'] as List?)?.map((e) => UserApp.fromJson(e)).toList() ?? [],
      reviews: (json['Reviews'] as List?)?.map((e) => Review.fromJson(e)).toList() ?? [],
    );
  }
}