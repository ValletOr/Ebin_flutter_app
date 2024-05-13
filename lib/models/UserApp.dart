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
      userId: json['UserId'] ?? 0,
      user: json['User'] != null ? User.fromJson(json['User']) : null,
      appId: json['AppId'] ?? 0,
      app: json['App'] != null ? AppModel.fromJson(json['App']) : null,
      appVersion: json['AppVersion'] ?? '',
    );
  }
}