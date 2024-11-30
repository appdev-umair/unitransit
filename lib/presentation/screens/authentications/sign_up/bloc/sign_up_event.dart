import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class SignUpNameChangedEvent extends SignUpEvent {
  final String name;
  const SignUpNameChangedEvent(this.name);

  @override
  List<Object?> get props => [name];
}

class SignUpGenderChangedEvent extends SignUpEvent {
  final String gender;
  const SignUpGenderChangedEvent(this.gender);

  @override
  List<Object?> get props => [gender];
}

class SignUpEmailChangedEvent extends SignUpEvent {
  final String email;
  const SignUpEmailChangedEvent(this.email);

  @override
  List<Object?> get props => [email];
}

class SignUpPasswordChangedEvent extends SignUpEvent {
  final String password;
  const SignUpPasswordChangedEvent(this.password);

  @override
  List<Object?> get props => [password];
}

class SignUpConfirmPasswordChangedEvent extends SignUpEvent {
  final String confirmPassword;
  const SignUpConfirmPasswordChangedEvent(this.confirmPassword);

  @override
  List<Object?> get props => [confirmPassword];
}

class SignUpTogglePasswordVisibilityEvent extends SignUpEvent {
  final bool isPasswordVisible;
  const SignUpTogglePasswordVisibilityEvent(this.isPasswordVisible);

  @override
  List<Object?> get props => [isPasswordVisible];
}

class SignUpToggleConfirmPasswordVisibilityEvent extends SignUpEvent {
  final bool isConfirmPasswordVisible;
  const SignUpToggleConfirmPasswordVisibilityEvent(
      this.isConfirmPasswordVisible);

  @override
  List<Object?> get props => [isConfirmPasswordVisible];
}

class SignUpSubmittedEvent extends SignUpEvent {
  const SignUpSubmittedEvent();
}
