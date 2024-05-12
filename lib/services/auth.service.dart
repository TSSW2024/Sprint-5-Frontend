import 'package:firebase_auth/firebase_auth.dart';

class AuthResult {
  final bool success;
  final String? errorMessage;

  AuthResult(this.success, this.errorMessage);
}

class AuthService {
  final FirebaseAuth _auth =
      FirebaseAuth.instance; // Creamos una instancia de Firebase.

  User? get user => _auth.currentUser; // Obtenemos el usuario actual.

  Future<AuthResult> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return AuthResult(true, null);
    } on FirebaseAuthException catch (e) {
      return AuthResult(false, e.message);
    } catch (e) {
      return AuthResult(false, 'Error desconocido $e');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<AuthResult> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return AuthResult(true, null);
    } on FirebaseAuthException catch (e) {
      return AuthResult(false, e.message);
    } catch (e) {
      return AuthResult(false, 'Error desconocido $e');
    }
  }
}
