class CardModel {
  final String id;
  final String type;
  final String name;
  final String description;
  final String author;
  final String pdf;
  final String photo;
  final String check;
  final String time;
  final String amount;
  final String link;
  final String? address;
  final String? number;

  CardModel({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    required this.author,
    required this.pdf,
    required this.photo,
    required this.check,
    required this.time,
    required this.amount,
    required this.link,
    this.address,
    this.number,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      author: json['author'] ?? '',
      pdf: json['pdf'] ?? '',
      photo: json['photo'] ?? '',
      check: json['check'] ?? '',
      time: json['time'] ?? '',
      amount: json['amount'] ?? '',
      link: json['link'] ?? '',
      address: json['address'],
      number: json['number'],
    );
  }
}
