import 'User.dart';
import 'CardModel.dart';

class UserApp {
  final int userId;
  final List? user;
  final int appId;
  final List? app;
  final String appVersion;

  UserApp({
    required this.userId,
    this.user,
    required this.appId,
    this.app,
    required this.appVersion,
  });

  factory UserApp.fromJson(Map<String, dynamic> json) {

    return UserApp(
      userId: json['user_id'] ?? 0,
      appId: json['app_id'] ?? 0,
      appVersion: json['app_version'] ?? '',
    );
  }
}