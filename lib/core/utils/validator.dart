import 'package:email_validator/email_validator.dart';

String? emailValidate(String? email) {
  if (email!.isEmpty) {
    return 'Email is required!';
  } else if (!EmailValidator.validate(email)) {
    return 'Email is invalid!';
  }
  return null;
}
