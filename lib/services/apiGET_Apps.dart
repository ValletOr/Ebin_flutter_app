import 'dart:convert';
import 'dart:io';

import 'package:enplus_market/models/ShortAppModel.dart';

const String apiResponse = '{"objects":[{"id":1,"name":"Name1","icon":"https://picsum.photos/512.jpg","size":"20","isInstalled":true},{"id":2,"name":"Name2","icon":"https://picsum.photos/512.jpg","size":"100","isInstalled":false},{"id":3,"name":"Name3","icon":"https://picsum.photos/512.jpg","size":"111","isInstalled":true},{"id":4,"name":"Name4","icon":"https://picsum.photos/512.jpg","size":"200","isInstalled":false},{"id":5,"name":"Name5","icon":"https://picsum.photos/512.jpg","size":"200","isInstalled":false},{"id":6,"name":"Name6","icon":"https://picsum.photos/512.jpg","size":"200","isInstalled":false},{"id":7,"name":"Name7","icon":"https://picsum.photos/512.jpg","size":"200","isInstalled":false},{"id":8,"name":"Name8","icon":"https://picsum.photos/512.jpg","size":"200","isInstalled":true},{"id":9,"name":"Name9","icon":"https://picsum.photos/512.jpg","size":"200","isInstalled":false},{"id":10,"name":"Name10","icon":"https://picsum.photos/512.jpg","size":"200","isInstalled":false}],"message":""}';

class ApiGET_Apps{

  List<ShortAppModel> apps = [];
  String message = "";

  Future<void> perform() async{
    //попытка сымитировать api запрос
    //==============================================================================
    String response = await Future.delayed(Duration(seconds: 2), () {
      return apiResponse;
    });
    //==============================================================================

    Map data = jsonDecode(response);

    //print("====TEST====");
    //(data["objects"] as List).forEach((item) => print(item));

    apps = (data["objects"] as List).map((item) => ShortAppModel.fromJson(item)).toList();
    message = data["message"];
  }
}