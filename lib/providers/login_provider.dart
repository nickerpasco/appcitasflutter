import 'package:app_salud_citas/utils/UIHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_salud_citas/services/auth_service.dart';
import 'package:app_salud_citas/models/LoginResponse.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  Future<bool> login(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      //_errorMessage = 'Por favor ingrese correo y contraseña.';

    
  
        UIHelper.mostrarMensajeDialog(
        context: context,
        titulo: 'Atención',
        mensaje: 'Por favor ingrese correo y contraseña.' ,
        icono: Icons.error_outline,
        colorIcono: Colors.orange,
        );

      // notifyListeners();
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
        //_errorMessage = 'Credenciales inválidas o servicio no disponible';

        UIHelper.mostrarMensajeDialog(
        context: context,
        titulo: 'Error',
        mensaje: 'Credenciales inválidas o servicio no disponible' ,
        icono: Icons.error_outline,
        colorIcono: Colors.redAccent,
        );


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


   Future<void> loginGmailInit() async {
    try {
      // isLoading = true;
      // notifyListeners();

      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        //errorMessage = "Inicio de sesión cancelado";
        return;
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      //errorMessage = e.message ?? "Error al iniciar sesión con Google";
    } catch (e) {
      //errorMessage = "Error inesperado al iniciar sesión con Google";
    } finally {
      // isLoading = false;
      // notifyListeners();
    }
  }
}
