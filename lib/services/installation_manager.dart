import 'package:enplus_market/models/ShortAppModel.dart';
import 'package:enplus_market/services/api_service.dart';
import 'package:enplus_market/services/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class InstallationManager{

  InstallationManager({required this.onStateChanged, required this.onInstallationProgressChanged, required this.onAppChanged});

  final List<ShortAppModel> _installationQueue = [];
  final List<ShortAppModel> _temporaryQueue = [];

  final ValueChanged<double> onInstallationProgressChanged;
  final ValueChanged<InstallationManagerStatus> onStateChanged;
  final ValueChanged<ShortAppModel> onAppChanged;

  InstallationManagerStatus _processingStatus = InstallationManagerStatus.idle;
  ShortAppModel? _processingApp;

  void addToQueue(ShortAppModel app){
    if (_installationQueue.contains(app) || _temporaryQueue.contains(app)) return;

    if (_processingStatus == InstallationManagerStatus.idle){
      _installationQueue.add(app);
      startProcessing();
    } else{
      _temporaryQueue.add(app);
    }
  }

  void removeFromQueue(ShortAppModel app){
    _temporaryQueue.remove(app);
  }

  List<ShortAppModel> getFullQueue(){

    List<ShortAppModel> fullList = [];

    if (_processingApp != null){
      fullList.addAll(_installationQueue.sublist(_installationQueue.indexOf(_processingApp!)));
      fullList.addAll(_temporaryQueue);
    }

    return fullList;
  }

  Future<void> startProcessing() async{

    ApiService apiService = ApiService();

    for (ShortAppModel app in _installationQueue) {

      _processingApp = app;
      onAppChanged(_processingApp!);

      _processingStatus = InstallationManagerStatus.downloading;
      onStateChanged(_processingStatus);

      String downloadedApp = await apiService.getDownload(app.id, (progress) { onInstallationProgressChanged(progress); });

      _processingStatus = InstallationManagerStatus.installing;
      onStateChanged(_processingStatus);

      //TODO: insert call for installation of downloadedApp

    }
    _processingApp = null;

    _installationQueue.clear();

    if (_temporaryQueue.isNotEmpty){
      _installationQueue.addAll(_temporaryQueue);
      _temporaryQueue.clear();
      startProcessing();
    } else{
      _processingStatus = InstallationManagerStatus.idle;
      onStateChanged(_processingStatus);
    }
  }
}