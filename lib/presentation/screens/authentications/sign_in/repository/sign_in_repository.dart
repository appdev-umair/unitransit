import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/token.dart';
import '/core/constants/url_constant.dart';

class SignInRepository {
  final Dio _dio = Dio();

  Future<Response> signIn({
    required String email,
    required String password,
  }) async {
    debugPrint(email);
    debugPrint(password);
    final data = {
      'email': email,
      'password': password,
      'role': "ROLE_STUDENT"
    };
    try {
      final response = await _dio.post(
        '${URLConstant.baseUrl}/auth/signin', // Update endpoint if needed
        data: data,
      );
      //ToDo: correct the format
      await storeToken(response.data);
      return response;
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.connectionError) {
        debugPrint('No internet connection');
        throw Exception('Please check your internet connection.');
      } else if (error.response != null) {
        debugPrint(
            'SignIn API error: ${error.response!.statusCode} - ${error.response!.data}');
        throw Exception(
            error.response!.data['message']); // Provide user-friendly message
      } else {
        debugPrint('SignIn unknown error: $error');
        throw Exception('An unknown error occurred');
      }
    } catch (e) {
      debugPrint('SignIn general error: $e');
      throw Exception('An error occurred during sign-in');
    }
  }
}
