class UpdatesModel {
  final String id;
  final String appId;
  final String version;
  final String date;
  final String description;
  final String filePath;
  final String? testFlight;

  UpdatesModel({
    required this.id,
    required this.appId,
    required this.version,
    required this.date,
    required this.description,
    required this.filePath,
    this.testFlight,
  });

  factory UpdatesModel.fromJson(Map<String, dynamic> json) {
    return UpdatesModel(
      id: json['id'] ?? '',
      appId: json['appId'] ?? '',
      version: json['version'] ?? '',
      date: json['date'] ?? 0,
      description: json['description'] ?? '',
      filePath: json['filePath'] ?? '',
      testFlight: json['testFlight'],
    );
  }
}


