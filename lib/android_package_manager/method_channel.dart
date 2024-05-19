import 'package:flutter/services.dart';

import 'package:enplus_market/services/constants.dart';
import 'enums.dart';
import 'platform.dart';

class MethodChannelAndroidPackageManager
    extends AndroidPackageManagerPlatform {
  final methodChannel = const MethodChannel(Constants.channelName);

  @override
  Future<PackageManagerStatus> execute(PackageManagerActionType type,
      String param) async {
    var actionName = type.name;
    final result = await methodChannel.invokeMethod<int>(actionName, param);

    return PackageManagerStatus.byCode(result);
  }
}