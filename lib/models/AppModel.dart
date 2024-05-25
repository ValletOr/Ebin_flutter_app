import 'package:enplus_market/models/Company.dart';
import 'package:enplus_market/models/Review.dart';
import 'package:enplus_market/models/Update.dart';
import 'package:enplus_market/models/User.dart';
import 'package:enplus_market/models/UserApp.dart';
import 'package:enplus_market/services/constants.dart';
import 'package:version/version.dart';


class AppModel {
  final int id;
  final String status;
  final String name;
  final String developer;
  final String? description;
  final String? minIos;
  final String? minAndroid;
  final String? icon;
  final List<String>? images;
  final List<Update>? updates;
  final List<User>? users;
  final List<UserApp>? userApps ;
  final List<Review>? reviews;
  final List<Company>? companies ;
  final String? size;
  bool isInstalled;
  final String access;
  final int downloads;
  final Update lastUpdate;
  final double rating;

  AppModel({
    required this.id,
    required this.name,
    required this.status,
    this.icon,
    required this.developer,
    this.description,
    this.images,
    this.minIos,
    this.minAndroid,
    this.size,
    required this.lastUpdate,
    this.updates,
    this.users,
    this.userApps,
    this.reviews,
    this.companies,
    required this.isInstalled,
    required this.access,
    required this.downloads,
    required this.rating,
  });

  factory AppModel.fromJson(Map<String, dynamic> json) {
    return AppModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      status: json['status'] ?? '',
      icon: (json['icon'] as String?)?.replaceFirst('wwwroot', Constants.API_BASE_URL) ?? '',
      description: json['description'] ?? '',
      developer: json['developer'] ?? '',
      images: (json['images'] as String?)?.split('\n').map((image) {
        return image.replaceFirst('wwwroot', Constants.API_BASE_URL);
      }).toList() ?? [],
      minIos: json['min_ios'] ?? '',
      minAndroid: json['min_android'] ?? '',
      size: json['size'] ?? '0 MB',
      lastUpdate: Update.fromJson(json['lastUpdate']),
      updates: (json['updates'] as List?)
          ?.map((e) => Update.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      users: (json['users'] as List?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      userApps: (json['userApps'] as List?)
          ?.map((e) => UserApp.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      reviews: (json['reviews'] as List?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      companies: (json['companies'] as List?)
          ?.map((e) => Company.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      isInstalled: json['isInstalled'] ?? false,
      access: json['access'] ?? '',
      downloads: json['downloads'] ?? 0,
      rating: json['rating'].toDouble() ?? 0.0,
    );
  }
}