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

        var json  =  jsonEncode(result.response.toJson());
        // Guardar en SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', result.token);
        await prefs.setString('user_data', jsonEncode(result.response.toJson()));


        SetearImagenLogin(json);

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
      //_errorMessage = 'Error de red: $e';


        UIHelper.mostrarMensajeDialog(
        context: context,
        titulo: 'Error',
        mensaje: 'Error interno : $e' ,
        icono: Icons.error_outline,
        colorIcono: Colors.redAccent,
        );



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

 


    Future<void> SetearImagenLogin(String json) async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('user_data');
    if (json != null) {
      final data = LoginResponse.fromJson(jsonDecode(json));
      

      String     fotoContain = "";
      String _nombreUsuario = data.data?.persona?.nombre ?? 'Usuario';

      String  _primerNombre = data.data?.persona?.nombre ?? '';
      String  _primerapellido = data.data?.persona?.apellidoPaterno ?? '';
      String  urlConFoto = data.data?.urlPublic?? '';
 
        data?.data?.pacienteEmpresa?.forEach((pacienteEmpresa) {
          fotoContain = pacienteEmpresa.cliente?.urlFoto?? '';
            
        }); 
    

      urlConFoto  = urlConFoto+fotoContain;

     await prefs.setString('urlImagenUsuarioLogin', urlConFoto);


    }
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
    // 1. Inicia el flujo de autenticación
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // 2. Obtiene los detalles de autenticación del usuario
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // 3. Crea una nueva credencial
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // 4. Inicia sesión en Firebase con la credencial
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    // 5. Imprime el nombre del usuario
    print(userCredential.user?.displayName);
  } catch (e) {
    print("Error al iniciar sesión con Google: $e");
  }


  }
}
