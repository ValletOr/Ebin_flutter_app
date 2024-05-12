class Account {
  final bool darkTheme;
  final bool pushInstall;
  final bool pushUpdate;
  final int userId;

  Account({
    required this.darkTheme,
    required this.pushInstall,
    required this.pushUpdate,
    required this.userId,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      darkTheme: json['darkTheme'] ?? false,
      pushInstall: json['pushInstall'] ?? true,
      pushUpdate: json['pushUpdate'] ?? true,
      userId: json['userId'] ?? 0,
    );
  }
}
