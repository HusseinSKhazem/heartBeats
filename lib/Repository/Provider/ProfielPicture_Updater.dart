import 'package:http/http.dart' as http;

class ProfilePictureUpdater {
  static Future<bool> uploadImage(String username, List<int> imageBytes) async {
    try {
      print('uploading image for ${username}');
      var url = Uri.parse('http://10.0.2.2:5292/api/User/UpdateProfilePicture?name=$username');
      var request = http.MultipartRequest('PUT', url)
        ..files.add(http.MultipartFile.fromBytes(
          'profilePicture',
          imageBytes,
          filename: 'profilePicture.png',
        ));

      var response = await request.send();
      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to update profile picture. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('An error occurred while updating the profile picture: $e');
      return false;
    }
  }
}
