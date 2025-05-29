import 'package:app_salud_citas/models/LoginResponse.dart';

class LoginResult {
  final LoginResponse response;
  final String token;

  LoginResult({required this.response, required this.token});
}