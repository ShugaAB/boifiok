import 'package:boifiok/user/auth/model/colours.dart';
import 'package:boifiok/user/auth/screen/button.dart';
import 'package:boifiok/user/auth/screen/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ForgotPassword> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<ForgotPassword> {

   TextEditingController emailController = TextEditingController();

   @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future  passwordReset() async{
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());

    //  if (!mounted) return; 

      showDialog(
        context: context, 
        builder: (context){
          return AlertDialog(
            content: Text('Password reset link sent! Check your email'),
          );
        });
    } on FirebaseAuthException 
    catch (e) {
      showDialog(
        context: context, 
        builder: (context){
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height =  MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: 
             Column(
              children: [
                Center(child: Image.asset('images/boifiok.jpg', height: 60,)),
                SizedBox(height: 40),
                Container(
                  width: 400,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        spreadRadius: 6,
                        color: Colors.black.withValues(alpha: 0.06),
                      )
                    ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(child: Image.asset("images/email.png", height: 60,)),
                      SizedBox(height: 20),
                           Text('Forgot Password?', 
                            style: TextStyle(color: Colors.black, 
                            fontSize: 30, 
                            fontWeight: FontWeight.bold),),
                            SizedBox(height: 10),
                            Text('Enter your email to reset your password'),
                          SizedBox(height: 20),

                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon: IconButton(
                            onPressed: (){}, 
                            icon: Icon(Icons.email_outlined, size: 16.0,)),
                            hintText: 'Email',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black12, width: 1
                              ), borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black12,
                              ),
                              borderRadius: BorderRadius.circular(10)
                            )
                        ),
                      ),
                      SizedBox(height: 16),
                      Button(onTap: passwordReset, 
                      buttonText: 'Reset Password'),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                          SizedBox(width: 3),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupScreen()));
                            },
                            child: Text('Sign up', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.lightGreen),))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      
    );
  }
}




