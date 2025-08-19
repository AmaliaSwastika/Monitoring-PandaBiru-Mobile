import 'package:flutter/material.dart';
import 'package:panda_biru/screen/navbar/navbar.dart';
import 'package:panda_biru/services/login_api.dart';
import 'package:panda_biru/theme/theme_text_style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:panda_biru/theme/theme_color.dart';
import 'package:panda_biru/model/login_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  String? _error;
  bool _obscurePassword = true; // untuk toggle password

  final ApiService _apiService = ApiService();

  Future<void> _handleLogin() async {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _error = "Username dan Password tidak boleh kosong!";
      });
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      UserModel user = await _apiService.login(
        _usernameController.text,
        _passwordController.text,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', user.username);
      await prefs.setString('token', user.token);
      await prefs.setString('email', user.email);

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => NavBar(username: user.username)),
      );
    } catch (e) {
      setState(() {
        _error = "Gagal login, Periksa username & password!";
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor().whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Image.asset(
                'assets/panda_logo/panda_logo.png',
                width: 150,
                height: 150,
              ),
              // const SizedBox(height: 5),
              Text(
                "Login",
                style: ThemeTextStyle().login
              ),
              const SizedBox(height: 5),
              Text(
                "Welcome! Silahkan login ke akun anda",
                style: ThemeTextStyle().login2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              TextField(
  controller: _usernameController,
  decoration: InputDecoration(
    labelText: "Username",
    prefixIcon: Icon(Icons.person, color: ThemeColor().blueColor),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: ThemeColor().blueColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: ThemeColor().blueColor),
    ),
  ),
),
const SizedBox(height: 20),
TextField(
  controller: _passwordController,
  obscureText: _obscurePassword,
  decoration: InputDecoration(
    labelText: "Password",
    prefixIcon: Icon(Icons.lock, color: ThemeColor().blueColor),
    suffixIcon: IconButton(
      icon: Icon(
        _obscurePassword ? Icons.visibility_off : Icons.visibility,
        color: ThemeColor().blueColor, // ubah warna mata
      ),
      onPressed: () {
        setState(() {
          _obscurePassword = !_obscurePassword;
        });
      },
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: ThemeColor().blueColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: ThemeColor().blueColor),
    ),
  ),
),

              const SizedBox(height: 20),
              if (_error != null)
                Text(
                  _error!,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: _loading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeColor().blueColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "Login",
                          style: ThemeTextStyle().buttonLogin
                        ),
                      ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
