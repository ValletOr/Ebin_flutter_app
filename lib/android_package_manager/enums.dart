enum PackageManagerStatus {
  success(0),
  failure(1),
  failureBlocked(2),
  failureAborted(3),
  failureInvalid(4),
  failureConflict(5),
  failureStorage(6),
  failureIncompatible(7),
  unknown(-2);

  final int code;

  static PackageManagerStatus byCode(int? code) {
    int codeFromParams = code ?? -2;
    PackageManagerStatus status;

    try {
      status = PackageManagerStatus.values
          .firstWhere((element) => (codeFromParams == element.code));
    }
    catch (_) {
      status = PackageManagerStatus.unknown;
    }

    return status;
  }

  const PackageManagerStatus(this.code);
}

enum PackageManagerActionType {
  install,
  uninstall;
}