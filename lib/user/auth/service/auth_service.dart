import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


//define the require things
//Sign up
  Future <String> signupUser({
    required String email,
    required String password,
    required String confirmPassword,
    required String name,
  }) async{
    try {
      //validate
      if (email.isEmpty || password.isEmpty || name.isEmpty || confirmPassword.isEmpty){
        return "Please enter all field";
      }
      //create new user
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password,
        );

      //store created user
      await _firestore.collection("users").doc(cred.user!.uid).set({
        "name": name,
        "uid": cred.user!.uid,
        "email": email,
        "createdAt": FieldValue.serverTimestamp(),
      });
      return "success"; // if sucess return the success message
    } catch (e) {
      return e.toString(); // if anything error display it
   }
  }
  //login
  //define the require things
//Sign up
  Future <String> loginUser({
    required String email,
    required String password,
  }) async{
    try {
      //validate
      if (email.isEmpty || password.isEmpty){
        return "Please enter all field";
      }
      //authenticate the user
      await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password);

      return "success"; // if sucess return the success message
    } catch (e) {
      return e.toString(); // if anything error display it
   }
  }
  //logout
  Future <void> signOut() async{
    await _auth.signOut();
  }
}// create riverpod provider for authmethod. It allow access to authentication method across the app
final authMethodProvider = Provider<AuthMethod>((ref){
  return AuthMethod();
});

