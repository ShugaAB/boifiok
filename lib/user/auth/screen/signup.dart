import 'package:boifiok/user/auth/model/colours.dart';
import 'package:boifiok/user/auth/screen/button.dart';
import 'package:boifiok/user/auth/screen/login.dart';
import 'package:boifiok/user/auth/screen/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<SignupScreen> {
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
                  height: height/1.4,
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
                        color: Colors.black.withOpacity(0.06),
                      )
                    ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                         Text('Sign up', style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),), 
                          //Expanded(child: 
                          
                      SizedBox(height: 20),
                      TextField(
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon: IconButton(
                            onPressed: (){}, 
                            icon: Icon(Icons.person_2_outlined, size: 16.0,)),
                            hintText: 'Enter your full name',
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
                      SizedBox(height: 4),
                      TextField(
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
                      SizedBox(height: 4),
                      TextField(
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon: IconButton(
                            onPressed: (){}, 
                            icon: Icon(Icons.lock, size: 16.0,)),
                            suffixIcon: IconButton(
                              onPressed: (){}, 
                              icon: Icon(Icons.visibility_off_outlined, size: 16.0,)),
                            hintText: 'Password',
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
                      SizedBox(height: 4),
                      TextField(
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon: IconButton(
                            onPressed: (){}, 
                            icon: Icon(Icons.lock, size: 16.0,)),
                            suffixIcon: IconButton(
                              onPressed: (){}, 
                              icon: Icon(Icons.visibility_off_outlined, size: 16.0,)),
                            hintText: 'Confirm Password',
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
                      SizedBox(height: 20),
                      Button(onTap: (){}, 
                      buttonText: 'Sign up'),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                          SizedBox(width: 3),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                            },
                            child: Text('Login', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.lightGreen),))
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text('Or'),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white
                        ),
                        onPressed: (){}, 
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(FontAwesomeIcons.google,),
                            SizedBox(width: 7),
                            Text('Sign up with Google', style: TextStyle(color: Colors.black),)
                          ],
                        ))    
                    ],
                  ),
                ),
                
                SizedBox(height: 6,)
              ],
            ),
          ),
        ),
      
    );
  }
}

