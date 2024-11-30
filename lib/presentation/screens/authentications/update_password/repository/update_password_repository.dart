import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:unitransit/core/constants/url_constant.dart';

class UpdatePasswordRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: URLConstant.baseUrl, // Replace with your base URL
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  Future<void> updatePassword({
    required String email,
    required String newPassword,
  }) async {
    debugPrint('Updating password');

    try {
      final response = await _dio.post(
        '/auth/reset-password', // Replace with your endpoint
        data: {
          'email': email,
          'newPassword': newPassword,
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update password. Please try again.');
      }
    } on DioException catch (e) {
      debugPrint('Update password API error: ${e.response?.data}');
      throw Exception(
        e.response?.data['message'] ??
            'An error occurred while updating the password',
      );
    } catch (e) {
      debugPrint('Update password general error: $e');
      throw Exception('An error occurred while updating the password');
    }
  }
}
