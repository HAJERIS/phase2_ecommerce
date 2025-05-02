import 'package:dio/dio.dart';

import '../models/user_model.dart';

class AuthService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://dummyjson.com'));

  Future<User> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {'username': username, 'password': password},
      );

      return User.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Login failed');
    }
  }
}
