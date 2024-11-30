import 'package:equatable/equatable.dart';


abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object?> get props => [];
}

class SignInEmailChangedEvent extends SignInEvent {
  final String email;

  const SignInEmailChangedEvent(this.email);

  @override
  List<Object?> get props => [email];
}

class SignInPasswordChangedEvent extends SignInEvent {
  final String password;

  const SignInPasswordChangedEvent(this.password);

  @override
  List<Object?> get props => [password];
}

class SignInRememberMeChangedEvent extends SignInEvent {
  final bool isRemembered;

  const SignInRememberMeChangedEvent(this.isRemembered);

  @override
  List<Object?> get props => [isRemembered];
}

class SignInTogglePasswordVisibilityEvent extends SignInEvent {
  final bool isPasswordVisible;

  const SignInTogglePasswordVisibilityEvent(this.isPasswordVisible);

  @override
  List<Object?> get props => [isPasswordVisible];
}

class SignInSubmittedEvent extends SignInEvent {
  const SignInSubmittedEvent();
}
