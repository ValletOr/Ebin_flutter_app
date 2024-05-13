import 'dart:convert';
import 'dart:io';

import '../models/AppModel.dart';

const String apiResponse = '{"objects": [{"id": "1","Status": "UnInstalled","Name": "En+ Binding: App For Best Сybersportsmens","Description": "Lorem ipsum dolor sit amet consectetur. Nisi pretium quam et vel imperdiet lorem. In adipiscing elit enim pellentesque id malesuada eleifend viverra. Mi nibh lectus in massa dis tristique egestas quam lectus. Sed tellus nibh egestas facilisis massa velit dolor ultrices. In enim venenatis mi tempus porta nunc massa dictum. Aliquet tincidunt dui pharetra lobortis. Nisl magna id eu interdum suscipit aliquam. Ac placerat proin elementum placerat et erat massa massa. In neque proin duis urna in sociis mauris a maecenas. Et felis amet posuere etiam lacinia in mattis. Orci morbi sapien in neque massa. Sit condimentum tristique ut eu ornare. Erat amet faucibus egestas amet leo felis elementum cras. Dolor neque aliquam diam cursus. Elementum et cum purus elit maecenas amet duis sed. Orci massa tincidunt non vel pellentesque dolor et. Dictum nec ut sit faucibus scelerisque. Id vel vulputate ipsum pharetra auctor praesent in urna. Ac elementum tristique ultrices sit dui a consequat consectetur adipiscing. Et felis amet posuere etiam lacinia in mattis. Orci morbi sapien in neque massa. Sit condimentum tristique ut eu ornare. Erat amet faucibus egestas amet leo felis elementum cras. Dolor neque aliquam diam cursus. Elementum et cum purus elit maecenas amet duis sed. Orci massa tincidunt non vel pellentesque dolor et. ","Developer": "Developer 1","MinIos": "iOS 10","MinAndroid": "Android 8","IconFile": "assets/img/log.png","ImagesFiles": ["assets/img/log.png","assets/img/1.jpg","assets/img/2.jpg","assets/img/3.jpg"],"Version": "1.0","ApkFile": "app1.apk","TestFlight": "TestFlight link for App 1","Companies": "Company 1"},{"id": "2","Status": "Installed","Name": "Game+Zone: Ultimate Gaming Experience","Description": "Suspendisse potenti nullam ac tortor vitae purus faucibus ornare suspendisse. Elementum facilisis leo vel fringilla est ullamcorper eget nulla facilisi. Enim ut sem viverra aliquet eget sit amet. Elementum facilisis leo vel fringilla est ullamcorper eget nulla facilisi. ","Developer": "Developer 2","MinIos": "iOS 12","MinAndroid": "Android 9","IconFile": "assets/img/1.jpg","ImagesFiles": ["assets/img/icon.png","assets/img/4.jpg","assets/img/5.jpg","assets/img/6.jpg"],"Version": "2.0","ApkFile": "app2.apk","TestFlight": "TestFlight link for App 2","Companies": "Company 2"},{"id": "3","Status": "Updating","Name": "Travel+Time: Your Personal Travel Companion","Description": "Vestibulum sed arcu non odio euismod lacinia at quis. Ut tellus elementum sagittis vitae et leo duis ut. In pellentesque massa placerat duis ultricies lacus sed turpis tincidunt. ","Developer": "Developer 3","MinIos": "iOS 11","MinAndroid": "Android 7","IconFile": "assets/img/travel_icon.png","ImagesFiles": ["assets/img/travel_icon.png","assets/img/7.jpg","assets/img/8.jpg","assets/img/9.jpg"],"Version": "3.0","ApkFile": "app3.apk","TestFlight": "TestFlight link for App 3","Companies": "Company 3"}],"message": "200"}';

class ApiGET_Apps{

  List<CardModel> apps = [];
  String message = "";

  Future<void> perform() async{
    //попытка сымитировать api запрос
    String response = await Future.delayed(Duration(seconds: 2), () {
      return apiResponse;
    });
    Map data = jsonDecode(response);

    apps = (data["objects"] as List).map((item) => CardModel.fromJson(item)).toList();
    message = data["message"];
  }
}