// TODO Implement this library.
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign up
  Future<User?> signUp(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print('Sign up error: $e');
      return null;
    }
  }

  // Log in
  Future<User?> login(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  // Log out
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Current user
  User? get currentUser => _auth.currentUser;

  // User UID
  String? get currentUID => _auth.currentUser?.uid;

  // User Email
  String? get currentEmail => _auth.currentUser?.email;
}
