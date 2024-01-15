import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  static const String userExistsWithCredentialError =
      'account-exists-with-different-credential';

  static const String emailInUseError = 'email-already-in-use';

  Future<dynamic> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return "User not found";
      } else if (e.code == "wrong-password") {
        return "Wrong password";
      } else {
        return "There was an error";
      }
    }
  }

  Future<dynamic> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        return "Weak password";
      } else if (e.code == emailInUseError) {
        return "Email already in use";
      } else {
        return "There was an error";
      }
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
