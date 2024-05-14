import 'package:enplus_market/models/AppModel.dart';
import 'package:enplus_market/models/User.dart';

class Company {
  final String name;
  final List<User>? users;
  final List<AppModel>? apps;

  Company({
    required this.name,
    this.users,
    this.apps,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['name'] ?? '',
      users: (json['users'] as List?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      apps: (json['apps'] as List?)
          ?.map((e) => AppModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }
}