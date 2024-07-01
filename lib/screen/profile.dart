import 'package:flutter/material.dart';
import 'package:sidang/screen/login.dart';
import 'package:sidang/screen/navbar.dart';
import 'package:sidang/service/api.dart';
import 'package:sidang/model/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Profile?> profileFuture;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    profileFuture = _fetchProfile();
  }

  Future<Profile?> _fetchProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('authToken');
    if (authToken != null) {
      return await apiService.fetchProfile(authToken);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to get auth token')),
      );
      return null;
    }
  }

   Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('authToken');

    if (authToken != null) {
      bool success = await apiService.logout(authToken);
      if (success) {
        await prefs.remove('authToken');
        _showLogoutDialog(context, 'Logout successfully', success);
      } else {
        _showLogoutDialog(context, 'Failed to logout', success);
      }
    } else {
      _showLogoutDialog(context, 'Auth token not found', false);
    }
  }

  void _showLogoutDialog(BuildContext context, String message, bool success) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.of(context).pop(true);
          if (success) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginForm()), 
              (Route<dynamic> route) => false,
            );
          }
        });

        return AlertDialog(
          title: const Text('Logout'),
          content: Text(message),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const NavBar(),
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.green[200],
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: FutureBuilder<Profile?>(
        future: profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No profile data'));
          } else {
            final profile = snapshot.data!;
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 350, 
                  child: Card(
                    color: Colors.green[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: profile.photo != null
                              ? NetworkImage(profile.photo)
                              : const AssetImage('images/profile.png') as ImageProvider<Object>,
                          ),
                          const SizedBox(height: 20),
                          _buildOutlinedListTile('Nama', profile.name),
                          _buildOutlinedListTile('NIM', profile.nim),
                          _buildOutlinedListTile('Email', profile.email),
                          _buildOutlinedListTile('Departemen', profile.departmentName),
                          _buildOutlinedListTile('Angkatan', profile.year.toString()),                         
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildOutlinedListTile(String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }

}
