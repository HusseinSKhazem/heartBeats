import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:heartbeats/Repository/Provider/Login_Model.dart';
import 'package:heartbeats/Repository/Provider/ProfilePicture_Model.dart';
import 'package:heartbeats/constants/Constants.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String? _username;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final loginModel = Provider.of<LoginModel>(context, listen: false);
      _username = await loginModel.getUsername();
      if (_username != null) {
        final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
        userProfileProvider.fetchUserProfileImage(_username!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, primaryColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        if (userProfileProvider.imageBytes == null)
                          const CircularProgressIndicator()
                        else
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: MemoryImage(userProfileProvider.imageBytes!),
                          ),
                        const SizedBox(height: 10),
                        Text(
                          _username ?? '',
                          style: const TextStyle(
                              color: primaryColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "Flutter Developer | Music Enthusiast",
                          style: TextStyle(color: primaryColor, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: Colors.white54),
                  Card(
                    color: Colors.white.withOpacity(0.8),
                    margin: const EdgeInsets.all(8.0),
                    elevation: 4.0,
                    child: Column(
                      children: [
                        _buildListTile(
                          icon: Icons.edit,
                          title: "Edit Profile",
                          onTap: () {},
                        ),
                        _buildListTile(
                          icon: Icons.lock_reset,
                          title: "Reset Password",
                          onTap: () {},
                        ),
                        _buildListTile(
                          icon: Icons.security,
                          title: "Privacy and Security",
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: primaryColor),
      title: Text(
        title,
        style: const TextStyle(color: primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: primaryColor),
      onTap: onTap,
    );
  }
}
