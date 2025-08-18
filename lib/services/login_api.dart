import 'package:dio/dio.dart';
import 'package:panda_biru/model/login_model.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://10.0.2.2:8000/api/v1", // ganti sesuai server kamu
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );

  Future<UserModel> login(String username, String password) async {
    try {
      final response = await _dio.post(
        "/login",
        data: {
          "username": username,
          "password": password,
        },
      );

      if (response.statusCode == 200 &&
          response.data['status'] == "success") {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? "Login gagal");
      }
    } on DioException catch (e) {
      throw Exception("Error API: ${e.response?.data ?? e.message}");
    }
  }
}
