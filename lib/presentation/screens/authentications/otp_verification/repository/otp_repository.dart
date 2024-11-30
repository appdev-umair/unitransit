import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants/url_constant.dart';

class OtpRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: URLConstant.baseUrl, // Replace with your base URL
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  Future<void> verifyOtp(String otp, String email, String ctx) async {
    try {
      debugPrint('$otp, $email, $ctx');
      debugPrint("");
      debugPrint("");
      debugPrint("");
      debugPrint('$otp, $email, $ctx');
      debugPrint('$otp, $email, $ctx');
      final response = await _dio.post(
        '/auth/verify-otp',
        data: {'otp': otp, 'email': email, 'context': ctx},
      );
      if (response.statusCode != 200) {
        throw Exception('OTP verificationfdsa failed');
      }
    } on DioException {
      throw Exception('OTP verification failedaz');
    } catch (e) {
      throw Exception('An error occurred during OTPfds verification');
    }
  }

  Future<void> resendOtp(String email, String ctx) async {

    
    try {
      debugPrint('Umair');
      final response = await _dio.post(
        '/auth/resend-otp',
        data: {'email': email, 'context': ctx},
      );
      
      if (response.statusCode != 200) {
        throw Exception('Failed to resend OTP');
      }
    } on DioException {

      throw Exception('Failed to resend OTP');
    } catch(e) {
      debugPrint("$e");
    }
  }
}
