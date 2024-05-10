class CardModel {
  final String id;
  final String Status;
  final String Name;
  final String Description;
  final String Developer;
  final String MinIos;
  final String MinAndroid;
  final String IconFile;
  final List ImagesFiles;
  final String Version;
  final String ApkFile;
  final String? TestFlight;
  final String? Companies;

  CardModel({
    required this.id,
    required this.Status,
    required this.Name,
    required this.Description,
    required this.Developer,
    required this.MinIos,
    required this.MinAndroid,
    required this.IconFile,
    required this.ImagesFiles,
    required this.Version,
    required this.ApkFile,
    this.TestFlight,
    this.Companies,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'] ?? '',
      Status: json['type'] ?? '',
      Name: json['name'] ?? '',
      Description: json['description'] ?? '',
      Developer: json['author'] ?? '',
      MinIos: json['pdf'] ?? '',
      MinAndroid: json['photo'] ?? '',
      IconFile: json['check'] ?? '',
      ImagesFiles: json['time'] ?? '',
      Version: json['amount'] ?? '',
      ApkFile: json['link'] ?? '',
      TestFlight: json['address'],
      Companies: json['number'],
    );
  }
}
