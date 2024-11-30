import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/icon_constant.dart';
import '../../../../core/constants/padding_constants.dart';
import '../../../../core/utils/navigation_service.dart';
import '../../../../core/utils/scaffold_messenger_service.dart';
import '../../../../routes/app_routes.dart';
import '../../../widgets/divider_or.dart';
import '../../../widgets/extra_text_button.dart';
import '../../../widgets/social_button.dart';
import 'bloc/sign_in_bloc.dart';
import 'bloc/sign_in_event.dart';
import 'bloc/sign_in_state.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final _signInFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
        leadingWidth: 70,
        ),
      body: BlocProvider(
        create: (context) => SignInBloc(),
        child: BlocListener<SignInBloc, SignInState>(
          listener: (context, state) {
            if (state.signInStatus == SignInStatus.error) {
              ScaffoldMessengerService().showErrorSnackbar(state.message);
            } else if (state.signInStatus == SignInStatus.success) {
              NavigationService().navigateToReplacement(AppRoutes.home);
            }
          },
          child: _buildSignInForm(context),
        ),
      ),
    );
  }

  Widget _buildSignInForm(BuildContext context) {
    return Padding(
      padding: PaddingConstant.horizontal,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Form(
                  key: _signInFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Welcome perks await!",
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      _buildEmailField(context),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      _buildPasswordField(context),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      _buildRememberMeAndForgotPassword(context),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      _buildSignInButton(context),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      const DividerOr(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      _buildSocialButtons(context),
                      const Spacer(),
                      _buildSignUpButton(context),
                      const SizedBox(
                        height: 30,
                      )
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
      onChanged: (email) =>
          context.read<SignInBloc>().add(SignInEmailChangedEvent(email)),
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (previous, current) =>
          previous.isPasswordVisible != current.isPasswordVisible,
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: "Password",
            suffixIcon: IconButton(
              icon: Icon(
                state.isPasswordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 20,
              ),
              onPressed: () => context.read<SignInBloc>().add(
                    SignInTogglePasswordVisibilityEvent(
                        !state.isPasswordVisible),
                  ),
            ),
          ),
          obscureText: !state.isPasswordVisible,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Password is required!';
            } else if (value.length < 8) {
              return 'Password must consist of 8 characters.';
            }
            return null;
          },
          onChanged: (password) => context
              .read<SignInBloc>()
              .add(SignInPasswordChangedEvent(password)),
        );
      },
    );
  }

  Widget _buildRememberMeAndForgotPassword(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (previous, current) =>
          previous.isRemembered != current.isRemembered,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: state.isRemembered,
                  visualDensity: VisualDensity.compact,
                  activeColor: ColorConstant.foregroundColor,
                  shape: const CircleBorder(),
                  onChanged: (value) {
                    context
                        .read<SignInBloc>()
                        .add(SignInRememberMeChangedEvent(value!));
                  },
                ),
                Text(
                  "Remember me",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 14),
                ),
              ],
            ),
            TextButton(
              onPressed: () =>
                  NavigationService().navigateTo(AppRoutes.forgotPasswordScreen),
              child: const Text(
                "Forgot Password?",
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (previous, current) =>
          previous.signInStatus != current.signInStatus,
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.signInStatus != SignInStatus.loading
              ? () {
                  if (_signInFormKey.currentState!.validate()) {
                    context
                        .read<SignInBloc>()
                        .add(const SignInSubmittedEvent());
                  }
                }
              : null,
          child: state.signInStatus == SignInStatus.loading
              ? const CircularProgressIndicator()
              : const Text("CONTINUE"),
        );
      },
    );
  }

  Widget _buildSocialButtons(BuildContext context) {
    return CustomSocialButton(
      iconPath: IconConstant.google,
      onClick: () {},
      text: "Log In with Google    ",
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return ExtraTextButton(
      text: "New User?",
      buttonText: "SIGN UP HERE",
      onClick: () => NavigationService().navigateTo(AppRoutes.signUpScreen),
    );
  }
}
