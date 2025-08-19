import 'package:flutter/material.dart';
import 'package:panda_biru/screen/login_screen.dart';
import 'package:panda_biru/theme/theme_color.dart';
import 'package:panda_biru/theme/theme_text_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _username;
  String? _email;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username');
      _email = prefs.getString('email');
    });
  }

  Future<void> _logout() async {
  final prefs = await SharedPreferences.getInstance();
  
  // Hapus data
  await prefs.remove('username');
  await prefs.remove('token');
  await prefs.remove('email');

  // Debug print
  final checkUsername = prefs.getString('username');
  final checkToken = prefs.getString('token');
  final checkEmail = prefs.getString('email');
  // ignore: avoid_print
  print("DEBUG: username after logout = $checkUsername"); // harus null
  // ignore: avoid_print
  print("DEBUG: token after logout = $checkToken");       // harus null
  // ignore: avoid_print
  print("DEBUG: email after logout = $checkEmail");       // harus null

  // Navigasi ke LoginScreen dan hilangkan semua screen sebelumnya
  if (!mounted) return;
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (_) => const LoginScreen()),
    (route) => false,
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor().whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: ThemeColor().blueColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Profile",
            style: ThemeTextStyle().appBar,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
        ),
      ),

      body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: Card(
              color: ThemeColor().whiteColor,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: ThemeColor().blueColor),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    if (_username != null)
                      Text(
                        "Username : $_username",
                        style: ThemeTextStyle().profile,
                      ),
                    if (_email != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        "Email : $_email",
                       style: ThemeTextStyle().profile
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 30), 
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _logout,
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeColor().blueColor,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
              ),
              child: Text("Logout", style: ThemeTextStyle().profile2,),
            ),
          ),
        ],
      ),
    ),
  );
}
}