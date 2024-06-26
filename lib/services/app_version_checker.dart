import 'package:enplus_market/models/AppModel.dart';
import 'package:enplus_market/models/ShortAppModel.dart';
import 'package:enplus_market/services/installed_app_finder.dart';
import 'package:installed_apps/app_info.dart';
import 'package:version/version.dart';

class AppVersionChecker{

  static Future<bool> isUpdatable({required ShortAppModel app}) async{
    AppInfo? instApp;

    try {
      instApp = await InstalledAppFinder.findInstalledApp(app.name);
    } catch (e){
      return false;
    }

    if (app.lastUpdate.version > Version.parse(instApp.versionName ?? "0.0.0")) {
      return true;
    }
    else {
      return false;
    }
  }
}
