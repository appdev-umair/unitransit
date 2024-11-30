import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/style.dart';
import 'package:unitransit/core/constants/color_constant.dart';

import '../../../../core/constants/padding_constants.dart';
import '../../../../core/utils/navigation_service.dart';
import '../../../../core/utils/scaffold_messenger_service.dart';
import '../../../../routes/app_routes.dart';
import 'package:otp_text_field/otp_text_field.dart';

import '../../../widgets/extra_text_button.dart';
import 'bloc/otp_bloc.dart';
import 'bloc/otp_event.dart';
import 'bloc/otp_state.dart';

class OtpVerificationScreen extends StatelessWidget {
  OtpVerificationScreen({super.key, required this.email, required this.ctx});
  final String email;
  final String ctx;
  final _otpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Retrieve the email passed from the SignUp screen

    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Verification"),
        leadingWidth: 70,
        leading: IconButton(
          style: IconButton.styleFrom(
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            iconSize: 20,
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocProvider(
        create: (context) => OtpBloc(),
        child: BlocListener<OtpBloc, OtpState>(
          listener: (context, state) {
            if (state.otpStatus == OtpStatus.error) {
              ScaffoldMessengerService().showErrorSnackbar(state.message);
            } else if (state.otpStatus == OtpStatus.success) {
              if (ctx == 'signup') {
                NavigationService()
                    .navigateTo(AppRoutes.home); // Navigate to home screen
              } else {
                NavigationService().navigateTo(AppRoutes.createNewPassword,
                    arguments: {'email': email});
              }
            }
          },
          child: _buildOtpForm(context, email), // Pass email to the form
        ),
      ),
    );
  }

  Widget _buildOtpForm(BuildContext context, String email) {
    return Padding(
      padding: PaddingConstant.horizontal,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Form(
                  key: _otpFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Enter the OTP sent to your email: $email", // Display email here
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      _buildOtpField(context),

                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),

                      _buildResendOtpButton(context), // Add this hereF
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      _buildVerifyButton(context),
                      const Spacer(),
                      ExtraTextButton(
                        text: ctx != 'signup'? 'Remember your password?': 'Already have an account?',
                        buttonText: 'SIGN IN HERE',
                        onClick: () {
                          NavigationService().navigateToReplacementUntil(
                              AppRoutes.signInScreen);
                        },
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOtpField(BuildContext context) {
    return BlocBuilder<OtpBloc, OtpState>(
      builder: (context, state) {
        return OTPTextField(
          length: 6, // Number of fields for OTP
          width: MediaQuery.of(context).size.width,
          fieldWidth: 40, // Width of each field
          otpFieldStyle: OtpFieldStyle(
            focusBorderColor: ColorConstant.primaryColor,
          ),
          style: const TextStyle(fontSize: 16),
          textFieldAlignment: MainAxisAlignment.spaceAround,
          fieldStyle: FieldStyle.box, // Display each field as a box
          onChanged: (code) {
            // Update OTP in Bloc when fields are changed
          },
          onCompleted: (verificationCode) {
            context.read<OtpBloc>().add(OtpChangedEvent(verificationCode));

            context.read<OtpBloc>().add(OtpSubmittedEvent(email, ctx));
          },
        );
      },
    );
  }

  Widget _buildResendOtpButton(BuildContext context) {
    return BlocBuilder<OtpBloc, OtpState>(
      builder: (context, state) {
        final isCooldown = state.resendCooldown > 0;
        return Row(
          children: [
            const Spacer(),
            TextButton(
              onPressed: isCooldown
                  ? null
                  : () {
                      context.read<OtpBloc>().add(ResendOtpEvent(email, ctx));
                    },
              child: isCooldown
                  ? Text('Resend OTP in ${state.resendCooldown}s')
                  : const Text("RESEND OTP"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildVerifyButton(BuildContext context) {
    return BlocBuilder<OtpBloc, OtpState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.otpStatus != OtpStatus.loading
              ? () {
                  if (_otpFormKey.currentState!.validate()) {
                    context.read<OtpBloc>().add(OtpSubmittedEvent(email, ctx));
                  }
                }
              : null,
          child: state.otpStatus == OtpStatus.loading
              ? const CircularProgressIndicator()
              : const Text("VERIFY OTP"),
        );
      },
    );
  }
}
