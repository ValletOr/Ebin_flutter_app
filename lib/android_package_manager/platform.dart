import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'enums.dart';
import 'method_channel.dart';

abstract class AndroidPackageManagerPlatform extends PlatformInterface {
  AndroidPackageManagerPlatform() : super(token: _token);

  static final Object _token = Object();

  static AndroidPackageManagerPlatform _instance =
    MethodChannelAndroidPackageManager();

  static AndroidPackageManagerPlatform get instance => _instance;

  static set instance(AndroidPackageManagerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<PackageManagerStatus> execute(PackageManagerActionType type,
      String param) {
    throw UnimplementedError('execute() has not been implemented.');
  }
}