class ShortAppModel {
  final int id;
  final String name;
  final String icon;
  final String size;
  final String? isInstalled;

  ShortAppModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.size,
    this.isInstalled,
  });

  factory ShortAppModel.fromJson(Map<String, dynamic> json) {
    return ShortAppModel(
      id: json['Id'] ?? 0,
      name: json['Name'] ?? '',
      icon: json['Icon'] ?? '',
      size: json['Size'] ?? '',
      isInstalled: json['IsInstalled'] ?? '',
    );
  }
}
