import 'package:boifiok/user/auth/model/colours.dart';
import 'package:boifiok/user/auth/screen/button.dart';
import 'package:boifiok/user/auth/screen/login.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
       // appBar: AppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Forgot password", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),),
                    
                    SizedBox(height: 15),
                    Text("Enter your email to receive an email to reset your password", style: TextStyle( color: Colors.black, fontSize: 16),),
                    SizedBox(height: 40),
                          TextField(
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                filled: true,
                                fillColor: Colors.white,
                                hoverColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black12, width: 3),
                                  borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.purple, width: 3),
                                  borderRadius: BorderRadius.circular(10)),
                                 ),
                                 style: TextStyle(),
                                 ),
                    
                    SizedBox(height: 15),
                    Button(onTap: (){}, 
                    buttonText: 'Send'),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have account?", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                              SizedBox(width:4),
                              GestureDetector(
                                child: Text("Login", style: TextStyle(color: AppColors.lightGreen, fontWeight: FontWeight.bold)),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                                },),
                            ],
                          )
                  ],
                ),
            ),
          )
      ),
    ));
  }
}