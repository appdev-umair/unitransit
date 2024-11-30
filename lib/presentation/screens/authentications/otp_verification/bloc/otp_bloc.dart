import 'dart:async';
import 'package:bloc/bloc.dart';
import '../repository/otp_repository.dart';
import 'otp_event.dart';
import 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(const OtpState()) {
    on<OtpChangedEvent>((event, emit) {
      emit(state.copyWith(otp: event.otp));
    });

    on<ResendOtpEvent>((event, emit) async {
      emit(state.copyWith(
        resendStatus: ResendOtpStatus.loading,
        resendCooldown: 30, // Set initial cooldown value
      ));
      try {
        await OtpRepository().resendOtp(event.email, event.ctx);
        emit(state.copyWith(
          resendStatus: ResendOtpStatus.success,
        ));

        // Start cooldown countdown
        await _startCooldownCountdown(emit);
      } catch (e) {
        emit(state.copyWith(
          resendStatus: ResendOtpStatus.error,
          message: 'Failed to resend OTP!',
        ));
      }
    });

    on<OtpSubmittedEvent>((event, emit) async {
      emit(state.copyWith(otpStatus: OtpStatus.loading));
      try {
        await OtpRepository()
            .verifyOtp(state.otp, event.email, event.ctx); // OTP verification
        emit(state.copyWith(otpStatus: OtpStatus.success));
      } catch (e) {
        emit(state.copyWith(
          otpStatus: OtpStatus.error,
          message: 'OTP verification failed!',
        ));
      }
    });
  }

  Future<void> _startCooldownCountdown(Emitter<OtpState> emit) async {
    int cooldown = 30;
    while (cooldown > 0) {
      await Future.delayed(const Duration(seconds: 1));
      cooldown--;

      // Check if the event handler is still active
      if (emit.isDone) break;

      emit(state.copyWith(resendCooldown: cooldown));
    }
  }
}
