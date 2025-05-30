import 'package:flutter/material.dart';
import 'package:app_salud_citas/services/auth_service.dart';
import 'package:app_salud_citas/models/LoginResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LoginProvider with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;
  LoginResponse? _loginResponse;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  LoginResponse? get loginResponse => _loginResponse;

  /// Realiza login con validación de campos vacíos
  Future<bool> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _errorMessage = 'Por favor ingrese correo y contraseña.';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await AuthService().loginPaciente(email, password);
      if (result  != null) {
        _loginResponse = result.response;

        // Guardar en SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', result.token);
        await prefs.setString('user_data', jsonEncode(result.response.toJson()));

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Credenciales inválidas o servicio no disponible';
      }
    } catch (e) {
      _errorMessage = 'Error de red: $e';
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
  }


  ///Lógica del btn del ojo
  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }


  void loginGmailInit(){

_errorMessage = 'Prueba';

  }
}
