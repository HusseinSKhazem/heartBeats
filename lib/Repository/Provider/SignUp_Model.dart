import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class SignUpModel with ChangeNotifier {
  String _name = '';
  String _password = '';
  bool _isLoading = false;
  String _errorMessage = '';

  // Getters
  String get name => _name;
  String get password => _password;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Setters
  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  Future<int> signUp() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    final url = Uri.parse('http://10.0.2.2:5292/api/Auth/Register');
    final headers = {"Content-Type": "application/json"};
    final body = json.encode({"name": _name, "password": _password});

    try {
      final response = await http.post(url, headers: headers, body: body);

      _isLoading = false;
      notifyListeners();

      if (response.statusCode == 200) {
        return 200;
      } else {
        _errorMessage = "Failed to sign up.";
        return response.statusCode;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = "Please check your connection and try again.";
      notifyListeners();
      return 500; 
    }
  }
}
