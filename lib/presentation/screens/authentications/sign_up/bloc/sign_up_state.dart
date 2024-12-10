import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

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
    this.profilePicture, 
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
  final XFile? profilePicture; // New field

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
    XFile? profilePicture, // New field
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
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  @override
  List<Object?> get props => [
        name,
        profilePicture,
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
