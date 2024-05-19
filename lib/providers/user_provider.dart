import 'package:enplus_market/exceptions/unauthorized_exception.dart';
import 'package:enplus_market/models/User.dart';
import 'package:enplus_market/services/api_service.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier{
  User? _userData;

  User? get userData => _userData;

  Future<void> getAccount() async{
    final apiService = ApiService();

    try {
      final response = await apiService.getAccount();
      final newUserData = User.fromJson(response['object']);
      _userData = newUserData;

      notifyListeners();

    }on UnauthorizedException{
      rethrow; //I don't like this implementation
    } catch (e) {
      String _err = "Fetching user error: $e";
      print(_err);
    }
  }

}