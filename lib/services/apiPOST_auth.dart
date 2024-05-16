import 'dart:convert';
import 'dart:io';

import 'package:enplus_market/models/ShortAppModel.dart';
import 'package:enplus_market/services/apiGET_apps.dart';
import 'package:http/http.dart';

class ApiPOST_auth{

  ApiPOST_auth({required this.phoneNumber, required this.otp});

  String endpointUrl = "http://10.0.2.2:8000/api/users/auth";

  String phoneNumber = "";
  String otp = "";

  String message = "";

  Future<void> perform() async{

    final Map<String, String> request ={
      "phone": phoneNumber,
      "code": otp,
    };

    final url = Uri.parse(endpointUrl);
    final response = await post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(request));

    if (response.statusCode == 200){
      Map data = jsonDecode(response.body);
      //message = data["message"];
      message = response.statusCode.toString();
    }else{
      throw Exception("Unable to login. Status code: ${response.statusCode}");
    }
  }
}