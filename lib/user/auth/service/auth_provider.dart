import 'package:boifiok/user/auth/model/auth_model.dart';
import 'package:flutter_riverpod/legacy.dart';

class AuthFormNotifier extends StateNotifier<AuthFormState>{
  AuthFormNotifier(): super (AuthFormState());

  void togglePasswordVisibility (){
    state = state.copyWith(isPasswordHidden: !state.isPasswordHidden);
  }

  void toggleConfirmPasswordVisibility (){
    state = state.copyWith(isConfirmPasswordHidden: !state.isConfirmPasswordHidden);
  }

  void updateName(String name){
    String? nameError;
    if(name.isNotEmpty && name.length < 6){
      nameError = 'Provide your full name';
    }
    state = state.copyWith(name: name, nameError: nameError);
  }

  void updateEmail(String email){
    String? emailError;
    if(email.isNotEmpty && !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)){
      emailError = 'Enter a valid email';
    }
    state = state.copyWith(email: email, emailError: emailError);
  }

  void updatePassword (String password){
    String? passwordError;
    if (password.isNotEmpty && password.length < 6){
      passwordError = 'Password must be atleast 6 characters';
    } 
    state = state.copyWith(password: password, passwordError: passwordError);
  }

  void updateConfirmPassword (String confirmPassword){
    String? confirmPasswordError;
    if (confirmPassword.isNotEmpty && confirmPassword.length < 6){
      confirmPasswordError = 'Password must be atleast 6 characters';
    } 
    state = state.copyWith(confirmPassword: confirmPassword, confirmPasswordError: confirmPasswordError);
  }

  void setLoading (bool isLoading){
    state = state.copyWith(isLoading: isLoading);
  }
}

final authFormProvider = StateNotifierProvider<AuthFormNotifier, AuthFormState>((ref){
  return AuthFormNotifier();
});