import 'dart:convert';
import 'package:enplus_market/services/constants.dart';
import 'package:enplus_market/exceptions/unauthorized_exception.dart';
import 'package:enplus_market/services/session_manager.dart';
import 'package:http/http.dart' as http;

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
    final url = Uri.parse('$baseUrl/users/code');
    final response = await http.post(
      url,
      headers: headers,
      body: "\"$phoneNumber\"",
    );

    return _handleResponse(response) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> authenticate(String phoneNumber, String otp) async {
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
    final url = Uri.parse('$baseUrl/users/logout');
    final response = await http.delete(url);

    await SessionManager.clearSessionId();

    _handleResponse(response);
  }

  Future<Map<String, dynamic>> getAccount() async {
    final url = Uri.parse('$baseUrl/users');

    String? sessionId = await SessionManager.getSessionId();

    headers['Cookie'] = "session_id=$sessionId";

    final response = await http.get(
      url,
      headers: headers,
    );

    return _handleResponse(response) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getApps(int mode) async {
    String? sessionId = await SessionManager.getSessionId();

    headers['Cookie'] = "session_id=$sessionId";

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

    print(response.body);

    return _handleResponse(response) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getAppDetails(int appId) async {
    String? sessionId = await SessionManager.getSessionId();

    headers['Cookie'] = "session_id=$sessionId";

    final url = Uri.parse('$baseUrl/apps/$appId');

    //print(url.toString());

    final response = await http.get(
      url,
      headers: headers,
    );

    print(response.body);

    return _handleResponse(response) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> postReview(int appId, int rating, String description) async {
    String? sessionId = await SessionManager.getSessionId();

    headers['Cookie'] = "session_id=$sessionId";

    final url = Uri.parse('$baseUrl/reviews');

    // Create the request body as a JSON map
    final requestBody = {
      "Rating": rating,
      "Description": description,
      "AppId": appId,
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(requestBody), // Encode the request body as JSON
    );

    print(response.body);

    return _handleResponse(response) as Map<String, dynamic>;
  }

}
