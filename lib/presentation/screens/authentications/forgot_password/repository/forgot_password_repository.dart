import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:unitransit/core/constants/url_constant.dart';

class ForgotPasswordRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: URLConstant.baseUrl, // Replace with your base URL
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );
  Future<void> resetPassword({required String email}) async {
    debugPrint('Requesting password reset for email: $email');

    try {
      // API request to send the reset password email
      final response = await _dio.post(
        '/auth/forgot-password', // Replace with your endpoint
        data: {
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        debugPrint('Password reset email sent successfully.');
      } else {
        debugPrint(
            'Failed to send password reset email. Status code: ${response.statusCode}');
        throw Exception('Failed to send password reset email.');
      }
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        debugPrint('No internet connection');
        throw Exception('Please check your internet connection.');
      } else if (error.response != null) {
        debugPrint('API error: ${error.response?.data}');
        throw Exception(
            error.response?.data['message'] ?? 'An error occurred.');
      } else {
        debugPrint('Unexpected error: $error');
        throw Exception('An unexpected error occurred.');
      }
    } catch (e) {
      debugPrint('General error: $e');
      throw Exception('An error occurred while requesting password reset.');
    }
  }
}
