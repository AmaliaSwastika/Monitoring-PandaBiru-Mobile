import 'package:dio/dio.dart';
import 'package:panda_biru/services/secret/constant.dart';
import 'package:panda_biru/model/attendance_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceAPI {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: APIConstant.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  // POST attendance dengan token
  Future<AttendanceModel> postAttendance({
    required String status,
    required String note,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    try {
      final response = await _dio.post(
        "/report/attendance",
        data: {
          "data": {"status": status, "note": note}
        },
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        return AttendanceModel.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? "Failed to submit attendance");
      }
    } on DioException catch (e) {
      throw Exception("Error API: ${e.response?.data ?? e.message}");
    }
  }
}
