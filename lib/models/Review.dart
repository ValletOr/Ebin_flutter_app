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
      userId: json['userId'] ?? 0,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      appId: json['appId'] ?? 0,
      app: json['app'] != null ? AppModel.fromJson(json['app']) : null,
      date: json['date'] ?? 0,
      rating: json['rating'] ?? 0,
      description: json['description'],
      isViewed: json['isViewed'] ?? false,
    );
  }
}