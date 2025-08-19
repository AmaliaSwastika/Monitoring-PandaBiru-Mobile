import 'package:dio/dio.dart';
import 'package:panda_biru/helper/shared_preferences.dart';
import 'package:panda_biru/model/report_summary_model.dart';
import 'package:panda_biru/services/secret/constant.dart';

class ActivityAPI {
  final Dio _dio = Dio();

  Future<ActivityResponse> getActivity() async {
    final token = await SharedPrefHelper.getToken();
    final response = await _dio.get(
      "${APIConstant.baseUrl}/report/summary",
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );

    return ActivityResponse.fromJson(response.data);
  }
}