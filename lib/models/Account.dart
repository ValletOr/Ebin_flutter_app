
import 'package:enplus_market/models/User.dart';

class Account {
  final bool darkTheme;
  final bool pushInstall;
  final bool pushUpdate;
  final int userId;
  final User? user;

  Account({
    required this.darkTheme,
    required this.pushInstall,
    required this.pushUpdate,
    required this.userId,
    this.user,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      darkTheme: json['darkTheme'] ?? false,
      pushInstall: json['pushInstall'] ?? true,
      pushUpdate: json['pushUpdate'] ?? true,
      userId: json['userId'] ?? 0,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}