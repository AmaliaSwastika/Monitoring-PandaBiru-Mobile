import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String? _username;
  bool _isLoading = true;

  String? get username => _username;
  bool get isLoading => _isLoading;

  AuthProvider() {
    checkLogin();
  }

  Future<void> checkLogin() async {
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    _username = prefs.getString('username');

    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('token');
    await prefs.remove('email');
    _username = null;
    notifyListeners();
  }

  Future<void> login(String username, String token, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('token', token);
    await prefs.setString('email', email);
    _username = username;
    notifyListeners();
  }
}
