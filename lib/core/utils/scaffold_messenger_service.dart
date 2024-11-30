import 'package:flutter/material.dart';

import '../constants/color_constant.dart';

class ScaffoldMessengerService {
  static final ScaffoldMessengerService _instance = ScaffoldMessengerService._internal();

  factory ScaffoldMessengerService() {
    return _instance;
  }

  ScaffoldMessengerService._internal();

  GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  void showErrorSnackbar(String message) {
    messengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: ColorConstant.errorColor,
      ),
    );
  }

  void showSuccessSnackbar(String message) {
    messengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}