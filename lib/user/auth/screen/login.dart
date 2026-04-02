import 'package:boifiok/user/auth/model/colours.dart';
import 'package:boifiok/user/auth/screen/button.dart';
import 'package:boifiok/user/auth/screen/forget_password.dart';
import 'package:boifiok/user/auth/screen/google_screen.dart';
import 'package:boifiok/user/auth/screen/signup.dart';
import 'package:boifiok/user/auth/service/auth_provider.dart';
import 'package:boifiok/user/auth/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isPasswordHidden = true;

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {

    final formState = ref.watch(authFormProvider);
    final formNotifier = ref.read(authFormProvider.notifier);
    final authMethod = ref.read(authMethodProvider);

    void login() async {
      formNotifier.setLoading(true);

      final res = await authMethod.loginUser(
        email: formState.email,
        password: formState.password,
      );
      formNotifier.setLoading(false);

      if(res == 'success'){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ForgotPassword()));
        mySnackBar(
          message: "Successful login",
          context: context,
          );
      } else {
        mySnackBar(message: res, context: context); 
      }
    }

    double height =  MediaQuery.of(context).size.height;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: ()=> FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
                          spreadRadius: 14,
                          color: Colors.black.withValues(alpha: 0.06),
                        )
                      ]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                           // Expanded(child: 
                             Text('Login', 
                              style: TextStyle(color: Colors.black, 
                              fontSize: 30, 
                              fontWeight: FontWeight.bold),),
                            SizedBox(height: 20),
                        TextField(
                          onChanged: (value)=> formNotifier.updateEmail(value),
                          onSubmitted: (value) => FocusScope.of(context).requestFocus(passwordFocus),
                          focusNode: emailFocus,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            errorText: formState.emailError,
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
                        SizedBox(height: 10),
                        TextField(
                          onChanged: (value) => formNotifier.updatePassword(value),
                          onSubmitted: (value) => FocusScope.of(context).unfocus(),
                          obscureText: isPasswordHidden,
                          focusNode: passwordFocus,
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                          errorText: formState.passwordError,
                            prefixIcon: IconButton(
                              onPressed: (){}, 
                              icon: Icon(Icons.lock, size: 16.0,)),
                              suffixIcon: IconButton(
                                onPressed: (){
                                  setState(() {
                                    isPasswordHidden = !isPasswordHidden;
                                  });
                                }, 
                                icon: Icon(isPasswordHidden ? Icons.visibility_off_outlined : Icons.visibility, size: 16.0,)),
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
                        SizedBox(height: 6),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPassword()));
                            },
                            child: Text('Forgot password?', style: TextStyle(color: AppColors.lightGreen, fontWeight: FontWeight.bold))),
                        ),
                        SizedBox(height: 10),
                        Button(onTap:
                          formState.isFormValid ? login : null,
                          buttonText: 'Login'), 
                        
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
                        SizedBox(height: 20),
                        GoogleLoginScreen()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        
      ),
    );
  }
}

void mySnackBar({required String message, required BuildContext context}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    ),
  );
}





