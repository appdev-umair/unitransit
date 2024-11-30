import 'package:equatable/equatable.dart';

enum OtpStatus { initial, loading, success, error }

enum ResendOtpStatus { initial, loading, success, error }

class OtpState extends Equatable {
  const OtpState({
    this.otp = '',
    this.otpStatus = OtpStatus.initial,
    this.resendStatus = ResendOtpStatus.initial,
    this.resendCooldown = 0,
    this.message = '',
  });

  final String otp;
  final OtpStatus otpStatus;
  final ResendOtpStatus resendStatus;
  final int resendCooldown; // Cooldown period in seconds
  final String message;

  OtpState copyWith({
    String? otp,
    OtpStatus? otpStatus,
    ResendOtpStatus? resendStatus,
    int? resendCooldown,
    String? message,
  }) {
    return OtpState(
      otp: otp ?? this.otp,
      otpStatus: otpStatus ?? this.otpStatus,
      resendStatus: resendStatus ?? this.resendStatus,
      resendCooldown: resendCooldown ?? this.resendCooldown,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props =>
      [otp, otpStatus, resendStatus, resendCooldown, message];
}
