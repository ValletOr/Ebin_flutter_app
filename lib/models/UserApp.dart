import 'package:enplus_market/models/AppModel.dart';
import 'package:enplus_market/models/User.dart';

class UserApp{
  final int userId;
  final User? user;
  final int appId;
  final AppModel? app;
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
      userId: json['userId'] ?? 0,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      appId: json['appId'] ?? 0,
      app: json['app'] != null ? AppModel.fromJson(json['app']) : null,
      appVersion: json['appVersion'] ?? '',
    );
  }
}