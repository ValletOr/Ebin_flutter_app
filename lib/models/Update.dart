import 'package:enplus_market/models/AppModel.dart';

class Update{
  final int appId;
  final AppModel? app;
  final String version;
  final int date;
  final String? description;
  final String? filePath;
  final String? testFlight;

  Update({
    required this.appId,
    this.app,
    required this.version,
    required this.date,
    this.description,
    this.filePath,
    this.testFlight,
  });

  factory Update.fromJson(Map<String, dynamic> json) {
    return Update(
      appId: json['AppId'] ?? 0,
      app: json['App'] != null ? AppModel.fromJson(json['App']) : null,
      version: json['Version'] ?? '',
      date: json['Date'] ?? 0,
      description: json['Description'],
      filePath: json['FilePath'],
      testFlight: json['TestFlight'],
    );
  }
}