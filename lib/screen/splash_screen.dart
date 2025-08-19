import 'package:flutter/material.dart';
import 'package:panda_biru/screen/login_screen.dart';
import 'package:panda_biru/screen/navbar/navbar.dart';
import 'package:panda_biru/theme/theme_color.dart';
import 'package:panda_biru/theme/theme_text_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    // Delay 3 detik
    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();
    final savedUsername = prefs.getString('username');

    if (!mounted) return;

    if (savedUsername != null) {
      // User sudah login → langsung ke NavBar
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => NavBar(username: savedUsername)),
      );
    } else {
      // User belum login → ke LoginScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor().blueColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/panda_logo/panda_logo.png',
              width: 180,
              height: 180,
            ),
            const SizedBox(height: 10),
            Text(
              "Panda Biru",
              style: ThemeTextStyle().splash,
            ),
          ],
        ),
      ),
    );
  }
}
