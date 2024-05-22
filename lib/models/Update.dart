import 'package:enplus_market/models/AppModel.dart';
import 'package:version/version.dart';

class Update{
  final int appId;
  final AppModel? app;
  final Version version;
  final DateTime date;
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
      appId: json['appId'] ?? 0,
      app: json['app'] != null ? AppModel.fromJson(json['app']) : null,
      version: Version.parse(json['version']),
      date: (DateTime.fromMillisecondsSinceEpoch(json['date'])) ?? DateTime(1970, 1, 1),
      description: json['description'] ?? '',
      filePath: json['filePath'] ?? '',
      testFlight: json['testFlight'] ?? '',
    );
  }
}