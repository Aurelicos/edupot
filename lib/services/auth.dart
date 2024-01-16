import 'package:edupot/providers/user_provider.dart';
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
    } on FirebaseAuthException {
      return false;
    }
  }

  Future<dynamic> createUserWithEmailAndPassword(
      String email, String password, String firstName, String lastName) async {
    final userProvider = UserProvider();
    userProvider.email = email;
    userProvider.firstName = firstName;
    userProvider.lastName = lastName;
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
