import 'package:equatable/equatable.dart';

enum SignUpStatus { initial, loading, success, error }

class SignUpState extends Equatable {
  const SignUpState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.gender = '',
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.message = '',
    this.signUpStatus = SignUpStatus.initial,
  });

  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String gender; // New property for gender
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final String message;
  final SignUpStatus signUpStatus;

  SignUpState copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    String? gender,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    String? message,
    SignUpStatus? signUpStatus,
  }) {
    return SignUpState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      gender: gender ?? this.gender, // Gender update
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      message: message ?? this.message,
      signUpStatus: signUpStatus ?? this.signUpStatus,
    );
  }

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        confirmPassword,
        gender,
        isPasswordVisible,
        isConfirmPasswordVisible,
        message,
        signUpStatus,
      ];
}
