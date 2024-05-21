import 'package:enplus_market/models/AppModel.dart';
import 'package:enplus_market/services/constants.dart';

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
      icon: (json['icon'] as String?)?.replaceFirst('wwwroot', Constants.API_BASE_URL) ?? '',
      size: json['size'] ?? '',
      isInstalled: json['isInstalled'] ?? '',
    );
  }

  factory ShortAppModel.fromAppModel(AppModel model){
    return ShortAppModel(
      id: model.id,
      name: model.name,
      icon: model.icon ?? "https://dummyimage.com/512",
      size: model.size ?? "",
      isInstalled: model.isInstalled,
    );
  }
}
