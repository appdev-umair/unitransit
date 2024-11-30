// lib/presentation/screens/auth/forgot_password/forgot_password_screen.dart

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitransit/core/utils/navigation_service.dart';
import 'package:unitransit/routes/app_routes.dart';

import '../../../../core/constants/padding_constants.dart';
import '../../../../core/utils/scaffold_messenger_service.dart';
import '../../../widgets/extra_text_button.dart';
import 'bloc/forgot_password_bloc.dart';
import 'bloc/forgot_password_event.dart';
import 'bloc/forgot_password_state.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final _forgotPasswordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
        leadingWidth: 70,
        leading: IconButton(
          style: IconButton.styleFrom(
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              iconSize: 20,
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocProvider(
        create: (context) => ForgotPasswordBloc(),
        child: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, state) {
            if (state.forgotPasswordStatus == ForgotPasswordStatus.error) {
              ScaffoldMessengerService().showErrorSnackbar(state.message);
            } else if (state.forgotPasswordStatus ==
                ForgotPasswordStatus.success) {
              ScaffoldMessengerService().showSuccessSnackbar(
                  'Password reset link sent to your email');
              NavigationService().navigateTo(
                AppRoutes.otpVerificationScreen,
                arguments: {"email": state.email, 'context': 'forgot_password'},
              );
            }
          },
          child: _buildForgotPasswordForm(context),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordForm(BuildContext context) {
    return Padding(
      padding: PaddingConstant.horizontal,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Form(
                  key: _forgotPasswordFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Reset your password",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Enter your email address and we'll send you instructions to reset your password.",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04),
                      _buildEmailField(context),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      _buildResetButton(context),
                      const Spacer(),
                      ExtraTextButton(
                        text: 'Remember your password?',
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

  Widget _buildEmailField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email is required!';
        } else if (!EmailValidator.validate(value)) {
          return 'Email is invalid!';
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Email",
      ),
      onChanged: (email) => context
          .read<ForgotPasswordBloc>()
          .add(ForgotPasswordEmailChangedEvent(email)),
    );
  }

  Widget _buildResetButton(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      buildWhen: (previous, current) =>
          previous.forgotPasswordStatus != current.forgotPasswordStatus,
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.forgotPasswordStatus != ForgotPasswordStatus.loading
              ? () {
                  if (_forgotPasswordFormKey.currentState!.validate()) {
                    context
                        .read<ForgotPasswordBloc>()
                        .add(const ForgotPasswordSubmittedEvent());
                  }
                }
              : null,
          child: state.forgotPasswordStatus == ForgotPasswordStatus.loading
              ? const CircularProgressIndicator()
              : const Text("RESET PASSWORD"),
        );
      },
    );
  }
}
