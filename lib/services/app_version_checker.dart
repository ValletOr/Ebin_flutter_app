import 'package:enplus_market/models/AppModel.dart';
import 'package:enplus_market/services/installed_app_finder.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:version/version.dart';

class AppVersionChecker{

  static Future<bool> isUpdateable({required AppModel app}) async{

    List<AppInfo> installedApps = await InstalledApps.getInstalledApps();
    AppInfo? instApp;

    try {
      instApp = await InstalledAppFinder.findInstalledApp(app.name);
    } catch (e){
      return false;
    }

    if (app.lastUpdate.version > Version.parse(instApp.versionName)) {
      return true;
    }
    else {
      return false;
    }
  }
}
