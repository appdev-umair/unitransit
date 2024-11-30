import 'package:equatable/equatable.dart';

abstract class UpdatePasswordEvent extends Equatable {
  const UpdatePasswordEvent();

  @override
  List<Object?> get props => [];
}

class UpdatePasswordChangedEvent extends UpdatePasswordEvent {
  final String password;

  const UpdatePasswordChangedEvent(this.password);

  @override
  List<Object?> get props => [password];
}

class UpdatePasswordConfirmChangedEvent extends UpdatePasswordEvent {
  final String confirmPassword;

  const UpdatePasswordConfirmChangedEvent(this.confirmPassword);

  @override
  List<Object?> get props => [confirmPassword];
}

class UpdatePasswordToggleVisibilityEvent extends UpdatePasswordEvent {
  final bool isVisible;

  const UpdatePasswordToggleVisibilityEvent(this.isVisible);

  @override
  List<Object?> get props => [isVisible];
}

class UpdatePasswordToggleConfirmVisibilityEvent extends UpdatePasswordEvent {
  final bool isVisible;

  const UpdatePasswordToggleConfirmVisibilityEvent(this.isVisible);

  @override
  List<Object?> get props => [isVisible];
}

class UpdatePasswordSubmittedEvent extends UpdatePasswordEvent {
  final String email;

  const UpdatePasswordSubmittedEvent(this.email);
  @override
  List<Object?> get props => [email];
}
