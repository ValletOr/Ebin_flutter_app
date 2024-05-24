import 'package:device_apps/device_apps.dart';

class InstalledAppFinder{

  static Future<Application> findInstalledApp(String appName) async{
    List<Application> installedApps = await DeviceApps.getInstalledApplications();

    for (var element in installedApps){
      if (appName.toLowerCase().contains(element.appName.toLowerCase())){
        return element;
      }
    }

    throw Exception("Installed app not found. Probably because our installed apps search is dumb");
  }

}