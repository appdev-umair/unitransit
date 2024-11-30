import 'package:flutter/material.dart';
import 'package:unitransit/presentation/screens/authentications/otp_verification/otp_verification_screen.dart';
import 'package:unitransit/presentation/screens/authentications/update_password/update_password_screen.dart';
import 'package:unitransit/presentation/screens/home/home_screen.dart';

import '../presentation/screens/authentications/forgot_password/forgot_password_screen.dart';
import '../presentation/screens/authentications/sign_in/sign_in_screen.dart';
import '../presentation/screens/authentications/sign_up/sign_up_screen.dart';

class AppRoutes {
  // Authentication-related routes
  static const String signInScreen = '/sign_in_screen';
  static const String signUpScreen = '/sign_up_screen';
  static const String otpVerificationScreen = '/otp_verification_screen';
  static const String createNewPassword = '/create_new_password';
  static const String resetPassword = '/reset_password';
  static const String forgotPasswordScreen = '/forgot_password_screen';
  static const String otpScreen = '/otp_screen';
  static const String emailVerification = '/email_verification';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Map<String, dynamic>? arguments =
        settings.arguments as Map<String, dynamic>?;
    switch (settings.name) {
      case signInScreen:
        // Handle SignInScreen route here
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case signUpScreen:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case otpVerificationScreen:
        return MaterialPageRoute(
            builder: (_) => OtpVerificationScreen(
                  email: arguments?['email'],
                  ctx: arguments?['context'],
                ));

      case forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case createNewPassword:
        return MaterialPageRoute(
            builder: (_) => UpdatePasswordScreen(
                  email: arguments?['email'],
                ));

      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      default:
        // Handle unknown routes
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Route not found!'),
            ),
          ),
        );
    }
  }
}
