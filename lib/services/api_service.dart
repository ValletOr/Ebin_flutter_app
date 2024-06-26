import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:enplus_market/services/constants.dart';
import 'package:enplus_market/exceptions/unauthorized_exception.dart';
import 'package:enplus_market/services/session_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ApiService {
  final String baseUrl = "${Constants.API_BASE_URL}/api";
  final Map<String, String> headers = {'Content-Type': 'text/json'};

  dynamic _handleResponse(http.Response response) {
    String respBody = response.body.isNotEmpty ? response.body : "{}";

    if (response.statusCode == 200) {
      return jsonDecode(respBody);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException("Unauthorized");
    } else {
      final errorData = jsonDecode(respBody);
      final errorMessage = errorData['message'] ?? 'Unknown error';
      throw Exception("API Error: $errorMessage, Code: ${response.statusCode}");
    }
  }

  Future<Map<String, dynamic>> sendOtp(String phoneNumber) async {
    headers['Content-Type'] = "text/json";

    final url = Uri.parse('$baseUrl/users/code');
    final response = await http.post(
      url,
      headers: headers,
      body: "\"$phoneNumber\"",
    );

    return _handleResponse(response) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> authenticate(String phoneNumber, String otp) async {
    headers['Content-Type'] = "text/json";

    final url = Uri.parse('$baseUrl/users/auth');
    final Map<String, String> requestBody = {"phone": phoneNumber, "code": otp};

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      String? sessionId = response.headers['set-cookie'];

      if (sessionId != null) {
        sessionId = sessionId.split(';')[0].split('=')[1];

        await SessionManager.saveSessionId(sessionId);
      }
    }

    return _handleResponse(response) as Map<String, dynamic>;
  }

  Future<void> logout() async {
    headers['Content-Type'] = "text/json";

    final url = Uri.parse('$baseUrl/users/logout');
    final response = await http.delete(url);

    await SessionManager.clearSessionId();

    _handleResponse(response);
  }

  Future<Map<String, dynamic>> getAccount() async {
    final url = Uri.parse('$baseUrl/users');

    String? sessionId = await SessionManager.getSessionId();

    headers['Cookie'] = "session_id=$sessionId";
    headers['Content-Type'] = "text/json";

    final response = await http.get(
      url,
      headers: headers,
    );

    return _handleResponse(response) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getApps(int mode) async {
    String? sessionId = await SessionManager.getSessionId();

    headers['Cookie'] = "session_id=$sessionId";
    headers['Content-Type'] = "text/json";

    Map<String, String> queryParameters = {};

    if (mode == 1) {
      queryParameters["IsTest"] = "true";
    } else if (mode == 2) {
      queryParameters["IsInstalled"] = "true";
    }

    final url = mode == 0
        ? Uri.parse('$baseUrl/apps')
        : Uri.parse('$baseUrl/apps').replace(queryParameters: queryParameters);

    final response = await http.get(
      url,
      headers: headers,
    );

    print("url: $url, apps: ${response.body}"); //TODO remove

    return _handleResponse(response) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getAppDetails(int appId) async {
    String? sessionId = await SessionManager.getSessionId();

    headers['Content-Type'] = "text/json";
    headers['Cookie'] = "session_id=$sessionId";

    final url = Uri.parse('$baseUrl/apps/$appId');

    final response = await http.get(
      url,
      headers: headers,
    );

    return _handleResponse(response) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> postReview(int appId, int rating, String description) async {
    String? sessionId = await SessionManager.getSessionId();

    final url = Uri.parse('$baseUrl/reviews');


    var request = http.MultipartRequest(
      "POST",
      url
    );

    request.fields["Rating"] = "$rating";
    request.fields["Description"] = description;
    request.fields["AppId"] = "$appId";

    request.headers['Cookie'] = "session_id=$sessionId";
    request.headers['Content-Type'] = "multipart/form-data";

    final responseStream = await request.send();
    final response = await http.Response.fromStream(responseStream);

    return _handleResponse(response) as Map<String, dynamic>;
  }

  Future<String> getDownload(int id, ValueChanged<double> onProgress) async {

    final ValueChanged<double> onReceiveProgress = onProgress;

    Map<String, String> queryParameters = {};
    queryParameters["appId"] = id.toString();
    final url = Uri.parse('$baseUrl/apps/download').replace(queryParameters: queryParameters);

    var appDocDir = await getTemporaryDirectory();
    String savePath = '${appDocDir.path}/downloaded_app.apk';

    String? sessionId = await SessionManager.getSessionId();

    Dio dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Cookie'] = "session_id=$sessionId";

    await dio.download(
        url.toString(),
        savePath,
        onReceiveProgress: (count, total) {
          onReceiveProgress(count / total);
        }
    );

    return savePath;
    //return _handleResponse(response) as Map<String, dynamic>;
  }

  Future<void> uninstallApp(int id) async {
    String? sessionId = await SessionManager.getSessionId();

    headers['Cookie'] = "session_id=$sessionId";
    headers['Content-Type'] = "text/json";

    Map<String, String> queryParameters = {};
    queryParameters["appId"] = id.toString();
    final url = Uri.parse('$baseUrl/apps/uninstall').replace(queryParameters: queryParameters);

    final response = await http.delete(url, headers: headers);

    _handleResponse(response);
  }

}
