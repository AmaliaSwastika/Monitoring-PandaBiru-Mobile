import 'dart:async';
import 'package:flutter/material.dart';
import 'package:panda_biru/theme/theme_color.dart';
import 'package:panda_biru/theme/theme_text_style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'navbar/navbar.dart';

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
    // Timer 3 detik untuk splash
    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();
    final savedUsername = prefs.getString('username');

    if (savedUsername != null) {
      // User sudah login → langsung ke NavBar
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => NavBar(username: savedUsername)),
      );
    } else {
      // User belum login → ke LoginScreen
      if (!mounted) return;
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
            width: 180, // sesuaikan ukuran
            height: 180,
          ),
          // const SizedBox(height: 5),
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
