// lib/presentation/screens/auth/forgot_password/bloc/forgot_password_state.dart

import 'package:equatable/equatable.dart';

enum ForgotPasswordStatus { initial, loading, success, error }

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    this.email = '',
    this.message = '',
    this.forgotPasswordStatus = ForgotPasswordStatus.initial,
  });

  final String email;
  final String message;
  final ForgotPasswordStatus forgotPasswordStatus;

  ForgotPasswordState copyWith({
    String? email,
    String? message,
    ForgotPasswordStatus? forgotPasswordStatus,
  }) {
    return ForgotPasswordState(
        email: email ?? this.email,
        message: message ?? this.message,
        forgotPasswordStatus: forgotPasswordStatus ?? this.forgotPasswordStatus);
  }

  @override
  List<Object?> get props => [
        email,
        message,
        forgotPasswordStatus,
      ];
}