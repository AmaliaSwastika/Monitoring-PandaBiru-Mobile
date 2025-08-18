import 'package:dio/dio.dart';
import 'package:panda_biru/model/store_model.dart';
import 'package:panda_biru/services/secret/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: APIConstant.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<List<StoreModel>> getStores() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    try {
      final response = await _dio.get(
        "/stores",
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final List stores = response.data['data'];
        return stores.map((json) => StoreModel.fromJson(json)).toList();
      } else {
        throw Exception(response.data['message'] ?? "Failed to load stores");
      }
    } on DioException catch (e) {
      throw Exception("Error API: ${e.response?.data ?? e.message}");
    }
  }
}
