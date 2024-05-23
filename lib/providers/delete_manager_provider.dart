import 'package:enplus_market/services/delete_manager.dart';
import 'package:enplus_market/services/enums.dart';
import 'package:flutter/cupertino.dart';

class DeleteManagerProvider extends ChangeNotifier{

  DeleteManagerProvider(){
    deleteManager = DeleteManager(
      onDeletionCompleted: deleted,
    );
  }

  late DeleteManager deleteManager;

  void deleted(){
    notifyListeners();
  }

}