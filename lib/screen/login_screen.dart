import 'package:flutter/material.dart';
import 'package:panda_biru/model/login_model.dart';
import 'package:panda_biru/screen/home_screen.dart';
import 'package:panda_biru/screen/navbar/navbar.dart';
import 'package:panda_biru/services/login_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  final ApiService _apiService = ApiService();

  Future<void> _handleLogin() async {
  setState(() {
    _loading = true;
    _error = null;
  });

  try {
    UserModel user = await _apiService.login(
      _usernameController.text,
      _passwordController.text,
    );

    // ✅ Print ID, Token, dan Email di debug console
    print("Login successfully!");
    print("ID: ${user.id}");
    print("Token: ${user.token}");
    print("Email: ${user.email}");

    // ✅ Simpan username, token & email ke SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', user.username);
    await prefs.setString('token', user.token);
    await prefs.setString('email', user.email);

    // ✅ Print konfirmasi simpan
    print("Username, Token & Email telah disimpan di SharedPreferences");
    print("Username: ${user.username}");
    print("Token: ${user.token}");
    print("Email: ${user.email}");

    // ✅ Navigasi ke NavBar
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => NavBar(username: user.username),
      ),
    );
  } catch (e) {
    setState(() {
      _error = e.toString();
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
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 10),
            _loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _handleLogin,
                    child: const Text("Login"),
                  ),
          ],
        ),
      ),
    );
  }
}
