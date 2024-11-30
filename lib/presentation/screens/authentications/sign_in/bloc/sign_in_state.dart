import 'package:equatable/equatable.dart';

enum SignInStatus { initial, loading, success, error }

class SignInState extends Equatable {
  const SignInState({
    this.email = '',
    this.password = '',
    this.isRemembered = false,
    this.isPasswordVisible = false,
    this.message = '',
    this.signInStatus = SignInStatus.initial,
  });

  final String email;
  final String password;
  final bool isRemembered;
  final bool isPasswordVisible;
  final String message;
  final SignInStatus signInStatus;

  SignInState copyWith({
    String? email,
    String? password,
    bool? isPasswordVisible,
    bool? isRemembered,
    String? message,
    SignInStatus? signInStatus,
  }) {
    return SignInState(
        email: email ?? this.email,
        password: password ?? this.password,
        isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
        isRemembered: isRemembered ?? this.isRemembered,
        message: message ?? this.message,
        signInStatus: signInStatus ?? this.signInStatus);
  }

  @override
  List<Object?> get props => [
        email,
        password,
        isPasswordVisible,
        isRemembered,
        message,
        signInStatus,
      ];
}
