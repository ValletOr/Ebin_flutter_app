
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
      darkTheme: json['DarkTheme'] ?? false,
      pushInstall: json['PushInstall'] ?? true,
      pushUpdate: json['PushUpdate'] ?? true,
      userId: json['UserId'] ?? 0,
      user: json['User'] != null ? User.fromJson(json['User']) : null,
    );
  }
}