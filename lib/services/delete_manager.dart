import 'package:device_apps/device_apps.dart';
import 'package:enplus_market/models/ShortAppModel.dart';
import 'package:enplus_market/services/api_service.dart';
import 'package:enplus_market/services/enums.dart';
import 'package:enplus_market/services/installed_app_finder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class DeleteManager{

  DeleteManager({required this.onDeletionCompleted});

  final ApiService _apiService = ApiService();

  final List<ShortAppModel> _deleteQueue = [];

  final VoidCallback onDeletionCompleted;

  DeleteManagerStatus _deleteStatus = DeleteManagerStatus.idle;
  ShortAppModel? _deletingApp;


  void addToQueue(List<ShortAppModel> apps){
    for (ShortAppModel app in apps){
      if (_deleteQueue.every((element) => element.id != app.id) && _deletingApp?.id != app.id){
        _deleteQueue.add(app);
      }
    }

    if (_deleteStatus == DeleteManagerStatus.idle){
      startProcessing();
    }
  }

  Future<void> startProcessing() async{
    _deletingApp = _deleteQueue.first;
    _deleteQueue.remove(_deletingApp);

    _deleteStatus = DeleteManagerStatus.deleting;
    final instApp = await InstalledAppFinder.findInstalledApp(_deletingApp!.name);
    DeviceApps.uninstallApp(instApp.packageName);
    await _apiService.uninstallApp(_deletingApp!.id);

    _deletingApp = null;

    if (_deleteQueue.isNotEmpty){
      startProcessing();
    } else{
      _deleteStatus = DeleteManagerStatus.idle;
      onDeletionCompleted();
    }
  }
}