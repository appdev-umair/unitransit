import 'package:bloc/bloc.dart';

import '../repository/sign_in_repository.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(const SignInState()) {
    on<SignInEmailChangedEvent>(_onEmailChanged);
    on<SignInPasswordChangedEvent>(_onPasswordChanged);
    on<SignInTogglePasswordVisibilityEvent>(_onPasswordVisibilityChanged);
    on<SignInRememberMeChangedEvent>(_onRememberMeChanged);
    on<SignInSubmittedEvent>(_onSignInClick);
  }

  void _onEmailChanged(
      SignInEmailChangedEvent event, Emitter<SignInState> emit) {
    emit(
      state.copyWith(
        email: event.email,
      ),
    );
  }

  void _onPasswordChanged(
      SignInPasswordChangedEvent event, Emitter<SignInState> emit) {
    emit(
      state.copyWith(
        password: event.password,
      ),
    );
  }

  void _onPasswordVisibilityChanged(
      SignInTogglePasswordVisibilityEvent event, Emitter<SignInState> emit) {
    emit(
      state.copyWith(
        isPasswordVisible: event.isPasswordVisible,
      ),
    );
  }

  void _onRememberMeChanged(
      SignInRememberMeChangedEvent event, Emitter<SignInState> emit) {
    emit(
      state.copyWith(
        isRemembered: event.isRemembered,
      ),
    );
  }

  Future<void> _onSignInClick(
      SignInSubmittedEvent event, Emitter<SignInState> emit) async {
    emit(state.copyWith(signInStatus: SignInStatus.loading));
    try {
      await SignInRepository().signIn(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(signInStatus: SignInStatus.success));
    } on Exception catch (error) {
      emit(state.copyWith(
          message: error.toString().split(": ")[1],
          signInStatus: SignInStatus.error));
    }

    emit(state.copyWith(signInStatus: SignInStatus.initial));
  }
}
