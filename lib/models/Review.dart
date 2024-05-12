import 'User.dart';
import 'CardModel.dart';

class Review {
  final int userId;
  final List? user;
  final int appId;
  final List? CardModel;
  final int date;
  final int rating;
  final String? description;
  final bool isViewed;

  Review({
    required this.userId,
    this.user,
    required this.appId,
    this.CardModel,
    required this.date,
    required this.rating,
    this.description,
    required this.isViewed,
  });

  factory Review.fromJson(Map<String, dynamic> json) {

    return Review(
      userId: json['user_id'] ?? 0,
      appId: json['app_id'] ?? 0,
      date: json['date'] ?? 0,
      rating: json['rating'] ?? 0,
      description: json['description'],
      isViewed: json['is_viewed'] ?? false,
    );
  }
}