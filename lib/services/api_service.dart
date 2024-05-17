import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://10.0.2.2:8000/api";
  final Map<String, String> headers = {
    'Content-Type': 'text/json'
  };

  dynamic _handleResponse(http.Response response) {

    String respBody = response.body.isNotEmpty ? response.body : "{}";

    if (response.statusCode == 200) {
      return jsonDecode(respBody);
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
    final Map<String,String> requestBody = {
      "phone": phoneNumber,
      "code": otp
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(requestBody),
    );

    return _handleResponse(response) as Map<String, dynamic>;
  }

  Future<void> logout() async {
    final url = Uri.parse('$baseUrl/users/logout');
    final response = await http.delete(url);
    _handleResponse(response);
  }


}