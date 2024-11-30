import 'package:equatable/equatable.dart';

abstract class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object?> get props => [];
}

class OtpChangedEvent extends OtpEvent {
  final String otp;
  const OtpChangedEvent(this.otp);

  @override
  List<Object?> get props => [otp];
}

class OtpSubmittedEvent extends OtpEvent {
  final String email;
  final String ctx;
  const OtpSubmittedEvent(this.email, this.ctx);

  @override
  List<Object?> get props => [email, ctx];
}

class ResendOtpEvent extends OtpEvent {
  final String email;
  final String ctx;

  const ResendOtpEvent(this.email, this.ctx);

  @override
  List<Object?> get props => [email, ctx];
}
