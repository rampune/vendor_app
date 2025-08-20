import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();


  static Future<User?> signInWithGoogle() async {
    try {

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print( "Sign-in aborted by user.");
        return null;
      }


      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );


      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      print(" Firebase sign-in successful: ${userCredential.user?.displayName} ${userCredential.user?.email}");
      return userCredential.user;
    } catch (e) {
      print(" Firebase Google Sign-In error: $e");
      return null;
    }
  }

  static Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      print("User signed out from Firebase and Google.");
    } catch (e) {
      print(" Sign out error: $e");
    }
  }
}
