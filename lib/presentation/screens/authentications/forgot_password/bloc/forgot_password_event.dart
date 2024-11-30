// lib/presentation/screens/auth/forgot_password/bloc/forgot_password_event.dart

import 'package:equatable/equatable.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object?> get props => [];
}

class ForgotPasswordEmailChangedEvent extends ForgotPasswordEvent {
  final String email;

  const ForgotPasswordEmailChangedEvent(this.email);

  @override
  List<Object?> get props => [email];
}

class ForgotPasswordSubmittedEvent extends ForgotPasswordEvent {
  const ForgotPasswordSubmittedEvent();
}