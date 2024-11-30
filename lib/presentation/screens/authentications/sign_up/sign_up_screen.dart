import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/icon_constant.dart';
import '../../../../core/constants/padding_constants.dart';
import '../../../../core/utils/navigation_service.dart';
import '../../../../core/utils/scaffold_messenger_service.dart';
import '../../../../routes/app_routes.dart';
import '../../../widgets/divider_or.dart';
import '../../../widgets/extra_text_button.dart';
import '../../../widgets/social_button.dart';

import 'bloc/sign_up_bloc.dart';
import 'bloc/sign_up_event.dart';
import 'bloc/sign_up_state.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final _signUpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
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
        create: (context) => SignUpBloc(),
        child: BlocListener<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state.signUpStatus == SignUpStatus.error) {
              ScaffoldMessengerService().showErrorSnackbar(state.message);
            } else if (state.signUpStatus == SignUpStatus.success) {
// First Screen: Passing Arguments
              NavigationService().navigateTo(
                AppRoutes.otpVerificationScreen,
                arguments: {"email": state.email, 'context': 'signup'},
              );
            }
          },
          child: _buildSignUpForm(context),
        ),
      ),
    );
  }

  Widget _buildSignUpForm(BuildContext context) {
    return Padding(
      padding: PaddingConstant.horizontal,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Form(
                  key: _signUpFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Create your account",
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      _buildNameField(context),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      _buildGenderField(
                          context), // Gender field with Male/Female
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      _buildEmailField(context),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      _buildPasswordField(context),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      _buildConfirmPasswordField(context),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      _buildSignUpButton(context),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      const DividerOr(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      _buildSocialButtons(context),
                      const Spacer(),
                      _buildSignInButton(context),
                      const SizedBox(height: 30)
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

  Widget _buildNameField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Name is required!';
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Full Name",
      ),
      onChanged: (name) =>
          context.read<SignUpBloc>().add(SignUpNameChangedEvent(name)),
    );
  }

  Widget _buildGenderField(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.gender != current.gender,
      builder: (context, state) {
        return DropdownButtonFormField<String>(
          value: state.gender.isNotEmpty ? state.gender : null,
          decoration: const InputDecoration(
            labelText: "Gender",
          ),
          style: const TextStyle(
            color: Colors.black, // Set the desired color
            fontSize: 16, // Optionally, adjust the font size
          ),
          items: const [
            DropdownMenuItem(value: "Male", child: Text("Male")),
            DropdownMenuItem(value: "Female", child: Text("Female")),
          ],
          onChanged: (gender) {
            if (gender != null) {
              context.read<SignUpBloc>().add(SignUpGenderChangedEvent(gender));
            }
          },
          validator: (value) => value == null || value.isEmpty
              ? 'Please select your gender!'
              : null,
        );
      },
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
          context.read<SignUpBloc>().add(SignUpEmailChangedEvent(email)),
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
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
              onPressed: () => context.read<SignUpBloc>().add(
                    SignUpTogglePasswordVisibilityEvent(
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
              .read<SignUpBloc>()
              .add(SignUpPasswordChangedEvent(password)),
        );
      },
    );
  }

  Widget _buildConfirmPasswordField(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
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
              onPressed: () => context.read<SignUpBloc>().add(
                    SignUpToggleConfirmPasswordVisibilityEvent(
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
          onChanged: (confirmPassword) => context
              .read<SignUpBloc>()
              .add(SignUpConfirmPasswordChangedEvent(confirmPassword)),
        );
      },
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) =>
          previous.signUpStatus != current.signUpStatus,
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.signUpStatus != SignUpStatus.loading
              ? () {
                  if (_signUpFormKey.currentState!.validate()) {
                    context
                        .read<SignUpBloc>()
                        .add(const SignUpSubmittedEvent());
                  }
                }
              : null,
          child: state.signUpStatus == SignUpStatus.loading
              ? const CircularProgressIndicator()
              : const Text("SIGN UP"),
        );
      },
    );
  }

  Widget _buildSocialButtons(BuildContext context) {
    return CustomSocialButton(
      iconPath: IconConstant.google,
      onClick: () {},
      text: "Sign up with Google    ",
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return ExtraTextButton(
      text: "Already have an account?",
      buttonText: "SIGN IN HERE",
      onClick: () => NavigationService().goBack(),
    );
  }
}
