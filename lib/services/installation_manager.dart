import 'package:apk_installer/apk_installer.dart';
import 'package:enplus_market/models/ShortAppModel.dart';
import 'package:enplus_market/services/api_service.dart';
import 'package:enplus_market/services/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class InstallationManager{

  InstallationManager({required this.onStateChanged, required this.onInstallationProgressChanged, required this.onAppChanged});

  final ApiService _apiService = ApiService();

  final List<ShortAppModel> _installationQueue = [];

  final ValueChanged<double> onInstallationProgressChanged;
  final ValueChanged<InstallationManagerStatus> onStateChanged;
  final ValueChanged<ShortAppModel> onAppChanged;

  InstallationManagerStatus _processingStatus = InstallationManagerStatus.idle;
  ShortAppModel? _processingApp;

  int queueSizeCounter = 0;

  void addToQueue(List<ShortAppModel> apps){
    for (ShortAppModel app in apps){
      if (_installationQueue.every((element) => element.id != app.id) && _processingApp?.id != app.id){
        _installationQueue.add(app);
        queueSizeCounter += 1;
      }
    }

    if (_processingStatus == InstallationManagerStatus.idle){
      startProcessing();
    }
  }

  void removeFromQueue(ShortAppModel app){
    _installationQueue.removeWhere((element) => element.id == app.id);
    queueSizeCounter -= 1;
  }

  List<ShortAppModel> getQueue(){
    return _installationQueue;
  }

  Future<void> startProcessing() async{

    //Selection
    _processingApp = _installationQueue.first;
    _installationQueue.remove(_processingApp);
    onAppChanged(_processingApp!);

    //Download
    _processingStatus = InstallationManagerStatus.downloading;
    onStateChanged(_processingStatus);

    String downloadedAppPath = await _apiService.getDownload(_processingApp!.id, (progress) { onInstallationProgressChanged(progress); });

    //Install
    _processingStatus = InstallationManagerStatus.installing;
    onStateChanged(_processingStatus);

    await ApkInstaller.installApk(filePath: downloadedAppPath);

    //"Endgame"
    _processingApp = null;

    if (_installationQueue.isNotEmpty){
      startProcessing();
    } else{
      _processingStatus = InstallationManagerStatus.idle;
      onStateChanged(_processingStatus);
      queueSizeCounter = 0;
    }
  }
}