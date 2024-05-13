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
      Status: json['Status'] ?? '', // Corrected key to 'Status'
      Name: json['Name'] ?? '', // Corrected key to 'Name'
      Description: json['Description'] ?? '', // Corrected key to 'Description'
      Developer: json['Developer'] ?? '', // Corrected key to 'Developer'
      MinIos: json['MinIos'] ?? '', // Corrected key to 'MinIos'
      MinAndroid: json['MinAndroid'] ?? '', // Corrected key to 'MinAndroid'
      IconFile: json['IconFile'] ?? '', // Corrected key to 'IconFile'
      ImagesFiles: (json['ImagesFiles'] as List?)?.map((e) => e as String).toList() ?? [],
      Version: json['Version'] ?? '', // Corrected key to 'Version'
      ApkFile: json['ApkFile'] ?? '', // Corrected key to 'ApkFile'
      TestFlight: json['TestFlight'],
      Companies: json['Companies'],
    );
  }
}
