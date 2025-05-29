import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/LoginResponse.dart';

class StorageService {
  static const _tokenKey = 'auth_token';
  static const _userDataKey = 'user_data';

  Future<void> saveLoginData(String token, LoginResponse loginResponse) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_userDataKey, jsonEncode(loginResponse.toJson()));
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<LoginResponse?> getLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_userDataKey);
    if (jsonString == null) return null;
    return LoginResponse.fromJson(jsonDecode(jsonString));
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userDataKey);
  }
}
