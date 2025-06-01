import 'package:app_salud_citas/models/LoginResponse.dart';

class LoginResult {
  final LoginResponse response;
  final String token;
  final String message;

  LoginResult({required this.response, required this.token,required this.message,});
}