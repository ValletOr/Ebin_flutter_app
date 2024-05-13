import 'package:enplus_market/models/Company.dart';
import 'package:enplus_market/models/Review.dart';
import 'package:enplus_market/models/Update.dart';
import 'package:enplus_market/models/User.dart';
import 'package:enplus_market/models/UserApp.dart';


class AppModel {
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
  final bool isInstalled;
  final String access;
  final int downloads;
  final Update lastUpdate;
  final double rating;

  AppModel({
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
      name: json['Name'] ?? '',
      status: json['Status'] ?? '',
      icon: json['Icon'] ?? '',
      description: json['Description'] ?? '',
      developer: json['Developer'] ?? '',
      images: (json['Images'] as List?)?.map((e) => e as String).toList() ?? [],
      minIos: json['MinIos'] ?? '',
      minAndroid: json['MinAndroid'] ?? '',
      size: json['Size'] ?? '',
      lastUpdate: Update.fromJson(json['LastUpdate']),
      updates: (json['Updates'] as List?)
          ?.map((e) => Update.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      users: (json['Users'] as List?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      userApps: (json['UserApps'] as List?)
          ?.map((e) => UserApp.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      reviews: (json['Reviews'] as List?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      companies: (json['Companies'] as List?)
          ?.map((e) => Company.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      isInstalled: json['IsInstalled'] ?? false,
      access: json['Access'] ?? '',
      downloads: json['Downloads'] ?? 0,
      rating: json['Rating'] ?? 0.0,
    );
  }
}