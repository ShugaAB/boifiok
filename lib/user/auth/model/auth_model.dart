class AuthFormState {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String? nameError;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;
  final bool isLoading;
  final bool isPasswordHidden;
  final bool isConfirmPasswordHidden;

//CONSTRUCTOR with default value for initialization
  AuthFormState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.nameError,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
    this.isLoading = false,
    this.isPasswordHidden = true,
    this.isConfirmPasswordHidden = true,
  });
//This is the get to determine if the form is validated
  bool get isFormValid =>
  emailError == null &&
  passwordError == null &&
  confirmPasswordError ==null &&
  (name.isEmpty || nameError == null);

//create a new instance for auth with update value

  AuthFormState copyWith ({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    String? nameError,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    bool? isLoading,
    bool? isPasswordHidden,
    bool? isConfirmPasswordHidden,
  }){
    return AuthFormState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      nameError: nameError,
      emailError: emailError,
      passwordError: passwordError,
      confirmPasswordError: confirmPasswordError,
      isLoading: isLoading ?? this.isLoading,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
      isConfirmPasswordHidden: isConfirmPasswordHidden ?? this.isConfirmPasswordHidden,
      );

  }

}