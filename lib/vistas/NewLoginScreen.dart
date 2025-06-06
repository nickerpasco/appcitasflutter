import 'package:app_salud_citas/vistas/CrearPacienteScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_salud_citas/vistas/selection_user_screen.dart';
import 'package:app_salud_citas/providers/login_provider.dart';

class NewLoginScreen extends StatelessWidget {
  const NewLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false, // <- Clave para evitar que se empuje el fondo
      body: Stack(
        children: [
          // Fondo estático
          Positioned.fill(
            child: Image.asset(
              'assets/NewLogin.png',
              fit: BoxFit.cover,
            ),
          ),

          // Contenido principal
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 40),
                        Center(
                          child: Image.asset('assets/drLink.png', height: 100),
                        ),
                        const SizedBox(height: 40),

                        // Campo Email
                        TextField(
                          controller: loginProvider.emailController,
                          decoration: InputDecoration(
                            hintText: 'Dirección de correo electrónico',
                            prefixIcon: const Icon(Icons.person_outline),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Campo Contraseña
                        TextField(
                          controller: loginProvider.passwordController,
                          obscureText: loginProvider.obscurePassword,
                          decoration: InputDecoration(
                            hintText: 'Contraseña',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                loginProvider.obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                loginProvider.togglePasswordVisibility();
                              },
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '¿Olvidó su contraseña?',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Botón Ingresar
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF145E5C),
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () async {
                            final success = await loginProvider.login(context);
                            if (success) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                  const SelectionUserScreen(),
                                ),
                              );
                            } else {
                              if (loginProvider.errorMessage != null) {
                                showCenteredPopup(
                                    context, loginProvider.errorMessage!);
                              }
                            }
                          },
                          child: loginProvider.isLoading
                              ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : const Text(
                            'Ingresar',
                            style: TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ),

                        const SizedBox(height: 16),

                        const Row(
                          children: [
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text("or"),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),

                        const SizedBox(height: 16),

                        OutlinedButton.icon(
                          onPressed: () {
                            loginProvider.loginGmailInit();
                          },
                          icon: Image.asset('assets/ic_google.png',
                              height: 24, width: 24),
                          label: const Text(
                            'Continuar con Google',
                            style:
                            TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            side: const BorderSide(color: Colors.black12),
                          ),
                        ),

                        const SizedBox(height: 40),

                        // Botón Registrarse
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CrearPacienteScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            '¿No tienes cuenta? Regístrate',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showCenteredPopup(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => Dialog(
      backgroundColor: const Color(0xFF145E5C),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 60),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    ),
  );
}
