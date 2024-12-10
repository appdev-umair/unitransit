import 'dart:convert';
import 'package:dio/dio.dart';

import '../../../../../core/constants/url_constant.dart';

class SignUpRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: URLConstant.baseUrl, // Replace with your base URL
      headers: {
        'Accept': '*/*', // Accept all response types
        'Connection': 'keep-alive',
      },
    ),
  );

  Future<void> signUp({
    required String name,
    required String gender,
    required String email,
    required String password,
  }) async {
    try {
      // Create FormData for multipart/form-data request
      FormData formData = FormData.fromMap({
        "user": jsonEncode({
          "name": name,
          "gender": gender,
          "email": email,
          "password": password,
          "role": "ROLE_STUDENT", // Assuming 'USER' is the default role
        }),
      });

      final response = await _dio.post(
        '/signup',
        data: formData, // Send FormData
        options: Options(
          headers: {
            "Content-Type":
                "multipart/form-data", // Explicitly set the content type
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Sign-up successful: ${response.data}');
      } else {
        print('Sign-up failed: ${response.statusCode} - ${response.data}');
      }
    } on DioException catch (error) {
      print('Error: ${error.message}');
      if (error.response != null) {
        print('Response: ${error.response?.data}');
      }
    } catch (e) {
      print('Unexpected error: $e');
    }
  }
}
