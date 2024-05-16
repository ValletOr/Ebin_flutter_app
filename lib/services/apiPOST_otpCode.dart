import 'dart:convert';
import 'dart:io';

import 'package:enplus_market/models/ShortAppModel.dart';
import 'package:enplus_market/services/apiGET_apps.dart';
import 'package:http/http.dart';

class ApiPOST_otpCode {

  ApiPOST_otpCode({required phoneNumber}){
    this.phoneNumber = "\"$phoneNumber\"";
  }

  String endpointUrl = "http://10.0.2.2:8000/api/users/code";

  String phoneNumber = "";

  String message = "";

  Future<void> perform() async {

    final url = Uri.parse(endpointUrl);
    final response = await post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: phoneNumber);

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      message = data["message"];
    } else {
      throw Exception("Unable to get OTP. Status code: ${response.statusCode}");
    }
  }
}