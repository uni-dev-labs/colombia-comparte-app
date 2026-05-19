import 'package:app/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  late final Dio _dio;

  AuthService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['BASE_URL'] ?? 'http://localhost:3000',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );
  }

  Future<UserResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      '/api/v1/user',
      data: {'email': email, 'password': password},
    );

    final data = response.data;
    if (data == null || data is! Map<String, dynamic>) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'El servidor devolvió una respuesta vacía o inválida',
      );
    }

    return UserResponse.fromJson(data);
  }
}
