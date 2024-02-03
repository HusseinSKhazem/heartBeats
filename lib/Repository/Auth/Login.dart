import 'dart:convert';
import 'package:http/http.dart' as http;


class ApiService {
  Future<http.Response> loginUser(String username, String password) async {
    final url = Uri.parse('http://10.0.2.2:5292/api/Auth/Login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to login with status code: ${response.statusCode}');
    }
  }
}
