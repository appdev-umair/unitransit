// lib/presentation/screens/auth/update_password/update_password_screen.dart

import 'package:unitransit/core/utils/navigation_service.dart';

import '../../../widgets/extra_text_button.dart';
import '/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/padding_constants.dart';
import '../../../../core/utils/scaffold_messenger_service.dart';
import 'bloc/update_password_bloc.dart';
import 'bloc/update_password_event.dart';
import 'bloc/update_password_state.dart';

class UpdatePasswordScreen extends StatelessWidget {
  UpdatePasswordScreen({super.key, required this.email});
  final String email;
  final _updatePasswordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Password"),
      ),
      body: BlocProvider(
        create: (context) => UpdatePasswordBloc(),
        child: BlocListener<UpdatePasswordBloc, UpdatePasswordState>(
          listener: (context, state) {
            if (state.updatePasswordStatus == UpdatePasswordStatus.error) {
              ScaffoldMessengerService().showErrorSnackbar(state.message);
            } else if (state.updatePasswordStatus ==
                UpdatePasswordStatus.success) {
              ScaffoldMessengerService()
                  .showSuccessSnackbar('Password updated. Please sign in.');
              NavigationService().navigateToReplacement(AppRoutes.signInScreen);
            }
          },
          child: _buildUpdatePasswordForm(context),
        ),
      ),
    );
  }

  Widget _buildUpdatePasswordForm(BuildContext context) {
    return Padding(
      padding: PaddingConstant.horizontal,
      child: Form(
        key: _updatePasswordFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            const Text(
              "Create New Password",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Your new password must be different from previous password",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            _buildPasswordField(context),
            const SizedBox(height: 16),
            _buildConfirmPasswordField(context),
            const SizedBox(height: 24),
            _buildUpdateButton(context),
            const Spacer(),
            ExtraTextButton(
              text: 'Remember your password?',
              buttonText: 'SIGN IN HERE',
              onClick: () {
                NavigationService()
                    .navigateToReplacementUntil(AppRoutes.signInScreen);
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return BlocBuilder<UpdatePasswordBloc, UpdatePasswordState>(
      buildWhen: (previous, current) =>
          previous.isPasswordVisible != current.isPasswordVisible,
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: "New Password",
            suffixIcon: IconButton(
              icon: Icon(
                state.isPasswordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 20,
              ),
              onPressed: () => context.read<UpdatePasswordBloc>().add(
                    UpdatePasswordToggleVisibilityEvent(
                        !state.isPasswordVisible),
                  ),
            ),
          ),
          obscureText: !state.isPasswordVisible,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Password is required!';
            } else if (value.length < 8) {
              return 'Password must be at least 8 characters.';
            }
            return null;
          },
          onChanged: (password) => context
              .read<UpdatePasswordBloc>()
              .add(UpdatePasswordChangedEvent(password)),
        );
      },
    );
  }

  Widget _buildConfirmPasswordField(BuildContext context) {
    return BlocBuilder<UpdatePasswordBloc, UpdatePasswordState>(
      buildWhen: (previous, current) =>
          previous.isConfirmPasswordVisible != current.isConfirmPasswordVisible,
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: "Confirm Password",
            suffixIcon: IconButton(
              icon: Icon(
                state.isConfirmPasswordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 20,
              ),
              onPressed: () => context.read<UpdatePasswordBloc>().add(
                    UpdatePasswordToggleConfirmVisibilityEvent(
                        !state.isConfirmPasswordVisible),
                  ),
            ),
          ),
          obscureText: !state.isConfirmPasswordVisible,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please confirm your password!';
            } else if (value != state.password) {
              return 'Passwords do not match!';
            }
            return null;
          },
          onChanged: (password) => context
              .read<UpdatePasswordBloc>()
              .add(UpdatePasswordConfirmChangedEvent(password)),
        );
      },
    );
  }

  Widget _buildUpdateButton(BuildContext context) {
    return BlocBuilder<UpdatePasswordBloc, UpdatePasswordState>(
      buildWhen: (previous, current) =>
          previous.updatePasswordStatus != current.updatePasswordStatus,
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.updatePasswordStatus != UpdatePasswordStatus.loading
              ? () {
                  if (_updatePasswordFormKey.currentState!.validate()) {
                    context
                        .read<UpdatePasswordBloc>()
                        .add(UpdatePasswordSubmittedEvent(email));
                  }
                }
              : null,
          child: state.updatePasswordStatus == UpdatePasswordStatus.loading
              ? const CircularProgressIndicator()
              : const Text("UPDATE PASSWORD"),
        );
      },
    );
  }
}
