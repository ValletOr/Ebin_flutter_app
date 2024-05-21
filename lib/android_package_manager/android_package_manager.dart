import 'enums.dart';
import 'platform.dart';

class AndroidPackageManager {

  static Future<PackageManagerStatus> execute(
      PackageManagerActionType type, String param) {

    Future<PackageManagerStatus> code =
        AndroidPackageManagerPlatform.instance.execute(type, param);

    return code;
  }
}
