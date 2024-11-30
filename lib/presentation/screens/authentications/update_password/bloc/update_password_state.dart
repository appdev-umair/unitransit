
import 'package:equatable/equatable.dart';

enum UpdatePasswordStatus { initial, loading, success, error }

class UpdatePasswordState extends Equatable {
  final String password;
  final String confirmPassword;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final UpdatePasswordStatus updatePasswordStatus;
  final String message;

  const UpdatePasswordState({
    this.password = '',
    this.confirmPassword = '',
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.updatePasswordStatus = UpdatePasswordStatus.initial,
    this.message = '',
  });

  UpdatePasswordState copyWith({
    String? password,
    String? confirmPassword,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    UpdatePasswordStatus? updatePasswordStatus,
    String? message,
  }) {
    return UpdatePasswordState(
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible: 
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      updatePasswordStatus: updatePasswordStatus ?? this.updatePasswordStatus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        password,
        confirmPassword,
        isPasswordVisible,
        isConfirmPasswordVisible,
        updatePasswordStatus,
        message,
      ];
}