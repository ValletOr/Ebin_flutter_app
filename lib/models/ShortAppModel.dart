class ShortAppModel {
  final int id;
  final String name;
  final String icon;
  final String size;
  final bool? isInstalled;

  ShortAppModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.size,
    this.isInstalled,
  });

  factory ShortAppModel.fromJson(Map<String, dynamic> json) {
    return ShortAppModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
      size: json['size'] ?? '',
      isInstalled: json['isInstalled'] ?? '',
    );
  }
}
