import 'package:flutter/material.dart';
import 'package:heartbeats/Repository/Auth/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginModel with ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = '';
  String _username = '';
  String _password = '';
  String _token = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  String get token => _token;

  void setUsername(String username) {
    _username = username;
  }

  Future<String> getUsername() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('username') ?? 'User 1';
}

  void setPassword(String password) {
    _password = password;
  }

  Future<void> login() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await ApiService().loginUser(_username, _password);
      _token = response.body;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token);
      await prefs.setString('username', _username);
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Incorrect name or password';
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
