import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  final auth = FirebaseAuth.instance;
   // create gogleSignIn instance
 // final googleSignIn = GoogleSignIn();
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  
  // method to sign in using google
  Future <bool> signInWithGoogle () async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      //check if user cancelled the sign in
      if (googleSignInAccount == null){
        return false; //user cancelled
      }
      
      
      //get authentication tokens
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      //create a firebase credential using the tokens from google
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken
      );

      //sign in to firebse using the google credential
      await auth.signInWithCredential(authCredential);
      return true; //sign in successful
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return false; // Error occurred
      //throw e;
    }
  }

  //method to sign out from both firebase and google
  googleSignOut() async {
    //sign out from firebase
    await auth.signOut();
    //from google
    await googleSignIn.signOut();
  }
}