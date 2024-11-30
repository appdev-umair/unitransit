// lib/presentation/screens/auth/forgot_password/bloc/forgot_password_bloc.dart


import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/forgot_password_repository.dart';
import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(const ForgotPasswordState()) {
    on<ForgotPasswordEmailChangedEvent>(_onEmailChanged);
    on<ForgotPasswordSubmittedEvent>(_onResetPasswordClick);
  }

  void _onEmailChanged(
      ForgotPasswordEmailChangedEvent event, Emitter<ForgotPasswordState> emit) {
    emit(
      state.copyWith(
        email: event.email,
      ),
    );
  }

  Future<void> _onResetPasswordClick(
      ForgotPasswordSubmittedEvent event, Emitter<ForgotPasswordState> emit) async {
    emit(state.copyWith(forgotPasswordStatus: ForgotPasswordStatus.loading));
    try {
      await ForgotPasswordRepository().resetPassword(
        email: state.email,
      );
      emit(state.copyWith(forgotPasswordStatus: ForgotPasswordStatus.success));
    } on Exception catch (error) {
      emit(state.copyWith(
          message: error.toString().split(": ")[1],
          forgotPasswordStatus: ForgotPasswordStatus.error));
    }

    emit(state.copyWith(forgotPasswordStatus: ForgotPasswordStatus.initial));
  }
}