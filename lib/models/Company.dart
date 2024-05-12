import 'UserApp.dart';
import 'CardModel.dart';

class Company {
  final String name;
  final List<CardModel> users;
  final List? apps;

  Company({
    required this.name,
    this.users = const [],
    this.apps = const [],
  });

  factory Company.fromJson(Map<String, dynamic> json) {
   //TODO:Надо чета тут накидать, но если тут накидывать, то и в App и CardModel тоже нужно накидать...
    return Company(
      name: json['name'] ?? '',
      //TODO:Надо чета тут накидать, но если тут накидывать, то и в App и CardModel тоже нужно накидать...
    );
  }
}