// lib/presentation/screens/auth/update_password/bloc/update_password_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/update_password_repository.dart';
import 'update_password_event.dart';
import 'update_password_state.dart';

class UpdatePasswordBloc extends Bloc<UpdatePasswordEvent, UpdatePasswordState> {
  UpdatePasswordBloc() : super(const UpdatePasswordState()) {
    on<UpdatePasswordChangedEvent>(_onPasswordChanged);
    on<UpdatePasswordConfirmChangedEvent>(_onConfirmPasswordChanged);
    on<UpdatePasswordToggleVisibilityEvent>(_onPasswordVisibilityChanged);
    on<UpdatePasswordToggleConfirmVisibilityEvent>(
        _onConfirmPasswordVisibilityChanged);
    on<UpdatePasswordSubmittedEvent>(_onUpdatePasswordClick);
  }

  void _onPasswordChanged(
      UpdatePasswordChangedEvent event, Emitter<UpdatePasswordState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _onConfirmPasswordChanged(
      UpdatePasswordConfirmChangedEvent event, Emitter<UpdatePasswordState> emit) {
    emit(state.copyWith(confirmPassword: event.confirmPassword));
  }

  void _onPasswordVisibilityChanged(
      UpdatePasswordToggleVisibilityEvent event,
      Emitter<UpdatePasswordState> emit) {
    emit(state.copyWith(isPasswordVisible: event.isVisible));
  }

  void _onConfirmPasswordVisibilityChanged(
      UpdatePasswordToggleConfirmVisibilityEvent event,
      Emitter<UpdatePasswordState> emit) {
    emit(state.copyWith(isConfirmPasswordVisible: event.isVisible));
  }

  Future<void> _onUpdatePasswordClick(
      UpdatePasswordSubmittedEvent event, Emitter<UpdatePasswordState> emit) async {
    if (state.password != state.confirmPassword) {
      emit(state.copyWith(
          message: 'Passwords do not match',
          updatePasswordStatus: UpdatePasswordStatus.error));
      return;
    }

    emit(state.copyWith(updatePasswordStatus: UpdatePasswordStatus.loading));
    try {
      await UpdatePasswordRepository().updatePassword(
        newPassword: state.password, email: event.email,
      );
      emit(state.copyWith(updatePasswordStatus: UpdatePasswordStatus.success));
    } on Exception catch (error) {
      emit(state.copyWith(
          message: error.toString().split(": ")[1],
          updatePasswordStatus: UpdatePasswordStatus.error));
    }
  }
}