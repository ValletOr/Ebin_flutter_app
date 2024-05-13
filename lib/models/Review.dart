import 'package:enplus_market/models/AppModel.dart';
import 'package:enplus_market/models/User.dart';

class Review {
  final int userId;
  final User? user;
  final int appId;
  final AppModel? app;
  final int date;
  final int rating;
  final String? description;
  final bool isViewed;

  Review({
    required this.userId,
    this.user,
    required this.appId,
    this.app,
    required this.date,
    required this.rating,
    this.description,
    required this.isViewed,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      userId: json['UserId'] ?? 0,
      user: json['User'] != null ? User.fromJson(json['User']) : null,
      appId: json['AppId'] ?? 0,
      app: json['App'] != null ? AppModel.fromJson(json['App']) : null,
      date: json['Date'] ?? 0,
      rating: json['Rating'] ?? 0,
      description: json['Description'],
      isViewed: json['IsViewed'] ?? false,
    );
  }
}