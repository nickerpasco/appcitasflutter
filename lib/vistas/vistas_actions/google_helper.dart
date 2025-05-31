import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential> signInWithGoogle() async {
  // Inicia el flujo de autenticación
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtiene los detalles de autenticación del request
  final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

  // Crea una nueva credencial
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Retorna la credencial con Firebase
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
