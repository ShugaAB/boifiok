import 'package:boifiok/user/Home/home.dart';
import 'package:boifiok/user/auth/service/google_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

//final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

class GoogleLoginScreen extends StatefulWidget {
  const GoogleLoginScreen({super.key});

  @override
  State<GoogleLoginScreen> createState() => _GoogleLoginScreenState();
}

class _GoogleLoginScreenState extends State<GoogleLoginScreen> {

  final FirebaseServices _firebaseServices = FirebaseServices();

 @override
  void initState() {
    super.initState();

    // Listen to user changes (for state updates)
    _firebaseServices.googleSignIn.onCurrentUserChanged.listen((account) {
      if (mounted) setState(() {});
    });

    // Try silent sign-in (auto-login if previously signed in)
    _firebaseServices.googleSignIn.signInSilently().then((account) {
      if (account != null) {
        // Auto-navigate if already signed in
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomePage()));
      }
    });
  }

  // @override
  // void initState(){
  //   super.initState();

  //   _googleSignIn.onCurrentUserChanged.listen((account){
  //     if (mounted){
  //       setState(() {
          
  //       });
  //     }
  //   });
  //   _googleSignIn.signInSilently();
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GestureDetector(
        onTap: () async {
          bool result = await FirebaseServices().signInWithGoogle();

          if (result) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Google sign in failed or cancel')));
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/google1.jpg', height: 30, width: 30,),
            SizedBox(width: 7),
            Text('Sign in with Google', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)
                            ],
        )
      ),
    );
  }
}