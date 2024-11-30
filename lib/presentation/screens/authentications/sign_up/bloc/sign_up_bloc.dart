// sign_up_bloc.dart
import 'package:bloc/bloc.dart';
import '../repository/sign_up_repository.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState()) {
    // Register event handlers using on<EventType>
    on<SignUpNameChangedEvent>((event, emit) {
      emit(state.copyWith(name: event.name));
    });
    on<SignUpGenderChangedEvent>((event, emit) {
      emit(state.copyWith(gender: event.gender));
    });

    on<SignUpEmailChangedEvent>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<SignUpPasswordChangedEvent>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<SignUpConfirmPasswordChangedEvent>((event, emit) {
      emit(state.copyWith(confirmPassword: event.confirmPassword));
    });

    on<SignUpTogglePasswordVisibilityEvent>((event, emit) {
      emit(state.copyWith(isPasswordVisible: event.isPasswordVisible));
    });
    on<SignUpToggleConfirmPasswordVisibilityEvent>((event, emit) {
      emit(state.copyWith(
          isConfirmPasswordVisible: event.isConfirmPasswordVisible));
    });

    on<SignUpSubmittedEvent>((event, emit) async {
      emit(state.copyWith(signUpStatus: SignUpStatus.loading));
      try {
        await SignUpRepository().signUp(
          name: state.name,
          gender: state.gender, // Added gender
          email: state.email,
          password: state.password,
        );
        emit(state.copyWith(signUpStatus: SignUpStatus.success));
      } on Exception catch (error) {
        emit(state.copyWith(
          message: error.toString().split(": ")[1],
          signUpStatus: SignUpStatus.error,
        ));
      }
      emit(state.copyWith(signUpStatus: SignUpStatus.initial));
    });
  }
}
