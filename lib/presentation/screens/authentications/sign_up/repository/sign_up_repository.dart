import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/url_constant.dart';

class SignUpRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: URLConstant.baseUrl, // Replace with your base URL
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  Future<void> signUp({
    required String name,
    required String gender,
    required String email,
    required String password,
  }) async {

    debugPrint(gender);
    try {
      final response = await _dio.post(
        '/auth/signup',
        data: {
          'name': name,
          'gender': gender,
          'email': email,
          'password': password,
        },
      );


    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        throw Exception('Please check your internet connection.');
      } else if (error.response != null) {
        throw Exception(error.response?.data['message'] ?? 'Sign-up error');
      } else {
        throw Exception('An unexpected error occurred');
      }
    } catch (e) {
      debugPrint('Umair: $e');
      throw Exception('An error occurred during sign-up');
    }
  }
}
