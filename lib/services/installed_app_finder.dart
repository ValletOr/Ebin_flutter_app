import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

class InstalledAppFinder{

  static Future<AppInfo> findInstalledApp(String appName) async{
    List<AppInfo> installedApps = await InstalledApps.getInstalledApps();

    for (var element in installedApps){
      if (element.name.toLowerCase().contains(appName.toLowerCase())){
        return element;
      }
    }

    throw Exception("Installed app not found. Probably because our installed apps search is dumb");
  }

}