import 'dart:convert';
import 'dart:io';

import '../models/AppModel.dart';

const String apiResponse = '{"object":{"status":"Available","name":"Example App","developer":"Example Developer","description":"This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.This is an example app description.","minIos":"14.0","minAndroid":"8.0","icon":"https://picsum.photos/512.jpg","images":["https://picsum.photos/1080/1920","https://picsum.photos/1080/1920","https://picsum.photos/1080/1920", "https://picsum.photos/1080/1920","https://picsum.photos/1080/1920"],"updates":[{"appId":1,"version":"1.0.0","date":1678886400,"description":"Initial release.","filePath":"https://example.com/app.apk","testFlight":null},{"appId":1,"version":"1.0.1","date":1681478400,"description":"Bug fixes and performance improvements.","filePath":"https://example.com/app_v1.0.1.apk","testFlight":"https://testflight.apple.com/join/example"}],"users":[{"name":"John","lastName":"Doe","middleName":null,"status":"Active","phone":"+15551234567","roleId":1,"companyId":1},{"name":"Jane","lastName":"Smith","middleName":null,"status":"Inactive","phone":"+15559876543","roleId":2,"companyId":2}],"userApps":[{"userId":1,"appId":1,"appVersion":"1.0.1"},{"userId":2,"appId":1,"appVersion":"1.0.0"}],"reviews":[{"userId":1,"appId":1,"date":1679577600,"rating":5,"description":"Great app!","isViewed":true},{"userId":2,"appId":1,"date":1680268800,"rating":3,"description":"Could use some improvements.","isViewed":false}],"companies":[{"name":"Example Company A"},{"name":"Example Company B"}],"size":"10","isInstalled":false,"access":"Public","downloads":1000,"lastUpdate":{"appId":1,"version":"1.0.1","date":1681478400,"description":"Bug fixes and performance improvements.","filePath":"https://example.com/app_v1.0.1.apk","testFlight":"https://testflight.apple.com/join/example"},"rating":4.5},"message":"Success"}';

class ApiGET_AppDetails{

  int id = 0;

  late AppModel app;
  String message = "";

  ApiGET_AppDetails({required int id}); //TODO ID передаётся, однако всегда возвращаяется один и тот же респонс, что логично, так как это хардкод строка с json зачем яэто пишу

  Future<void> perform() async{
    //попытка сымитировать api запрос
    //==============================================================================
    String response = await Future.delayed(Duration(seconds: 2), () {
      return apiResponse;
    });
    //==============================================================================

    Map data = jsonDecode(response);

    app = AppModel.fromJson(data["object"]);
    message = data["message"];
  }
}