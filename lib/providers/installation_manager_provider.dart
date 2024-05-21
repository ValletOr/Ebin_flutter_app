import 'package:enplus_market/models/ShortAppModel.dart';
import 'package:enplus_market/services/enums.dart';
import 'package:enplus_market/services/installation_manager.dart';
import 'package:flutter/cupertino.dart';

class InstallationManagerProvider extends ChangeNotifier{

  InstallationManagerProvider(){
    installationManager = InstallationManager(
        onStateChanged: changeStatus,
        onInstallationProgressChanged: changeProgress,
        onAppChanged: changeApp
    );
  }

  late InstallationManager installationManager;

  InstallationManagerStatus installationStatus = InstallationManagerStatus.idle;
  double installationProgress = 0.0;
  ShortAppModel? processingApp;

  void changeStatus(state){
    installationStatus = state;
    notifyListeners();
  }

  void changeProgress(progress){
    installationProgress = progress;
    notifyListeners();
  }

  void changeApp(app){
    processingApp = app;
    notifyListeners();
  }

}