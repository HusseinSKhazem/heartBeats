import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProfileProvider with ChangeNotifier {
  Uint8List? _imageBytes;

  Uint8List get imageBytes => _imageBytes!;

  Future<void> fetchUserProfileImage(String username) async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:5292/api/User/GetProfilePicture?username=$username'),
    );

    if (response.statusCode == 200) {
      _imageBytes = response.bodyBytes;
    } else {
      _imageBytes = null;
    }
    notifyListeners();
  }
}