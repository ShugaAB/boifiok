import 'package:boifiok/user/auth/model/colours.dart';
import 'package:boifiok/user/auth/screen/button.dart';
import 'package:boifiok/user/auth/screen/google_screen.dart';
import 'package:boifiok/user/auth/screen/login.dart';
import 'package:boifiok/user/auth/service/auth_provider.dart';
import 'package:boifiok/user/auth/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<SignupScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();

  String passwordError = "";
  String confirmPasswordError = "";

  void _validatePasswords() {
  setState(() {
    passwordError = passwordController.text.isEmpty
        ? "Password cannot be empty"
        : "";

    confirmPasswordError = confirmPasswordController.text != passwordController.text
    ? "Passwords do not match"
    : "";
  });
}

  @override
  Widget build(BuildContext context) {

     final formState = ref.watch(authFormProvider);
    final formNotifier = ref.read(authFormProvider.notifier);
    final authMethod = ref.read(authMethodProvider);

    void signup() async {
      formNotifier.setLoading(true);

      final res = await authMethod.signupUser(
        email: formState.email,
        password: formState.password,
        confirmPassword: formState.confirmPassword,
        name: formState.name,
      );
      formNotifier.setLoading(false);

      if(res == 'success'){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
        mySnackBar(
          message: "Signup successful. Now turn to login",
          context: context,
          );
      } else {
        mySnackBar(message: res, context: context); 
      }
    }

    double height =  MediaQuery.of(context).size.height;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
                          spreadRadius: 6,
                          color: Colors.black.withValues(alpha: 0.06),
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
                          onChanged: (value)=> formNotifier.updateName(value),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            errorText: formState.nameError,
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
                          onChanged: (value)=>formNotifier.updateEmail(value),
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
                        SizedBox(height: 4),
                        TextField(
                          onChanged: (value) => formNotifier.updatePassword(value),
                          obscureText: formState.isPasswordHidden,
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
                                onPressed: ()=> formNotifier.togglePasswordVisibility(), 
                                icon: Icon(formState.isPasswordHidden ? Icons.visibility_off_outlined: Icons.visibility, size: 16.0,)),
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
                          onChanged: (value) => _validatePasswords(),
                          obscureText: formState.isConfirmPasswordHidden,
                          focusNode: confirmPasswordFocus,
                          controller: confirmPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            errorText: confirmPasswordError.isEmpty ? null : confirmPasswordError,
                            prefixIcon: IconButton(
                              onPressed: (){},   
                              icon: Icon(Icons.lock, size: 16.0,)),
                              suffixIcon: IconButton(
                                onPressed: ()=> formNotifier.toggleConfirmPasswordVisibility(), 
                                icon: Icon(formState.isConfirmPasswordHidden ? Icons.visibility_off_outlined : Icons.visibility_sharp, size: 16.0,)),
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
                        Button(
                          onTap: formState.isFormValid ? signup : null,
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
                        GoogleLoginScreen(),   
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 6,)
                ],
              ),
            ),
          ),
        
      ),
    );
  }
}

