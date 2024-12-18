import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_app/services/databases/database.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;
  static final User? loggedInUser = _auth.currentUser;

  static String? get currentUserId => loggedInUser?.uid;
  static String? get currentUserEmail => loggedInUser?.email;

  static Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Database.usersCollection
          .doc(userCredential.user!.uid)
          .set({'uid': userCredential.user?.uid, 'email': email});
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  static Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      Database.usersCollection
          .doc(userCredential.user!.uid)
          .set({'uid': userCredential.user?.uid, 'email': email});
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  static String? getCurrentUserEmail() {
    return _auth.currentUser?.email;
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }
}
