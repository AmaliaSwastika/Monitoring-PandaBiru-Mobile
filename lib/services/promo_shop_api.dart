import 'package:dio/dio.dart';
import 'package:panda_biru/helper/shared_preferences.dart';
import 'package:panda_biru/model/promo_shop_model.dart';
import 'package:panda_biru/services/secret/constant.dart';

class PromoAPI {
  final Dio _dio = Dio();

  Future<bool> submitPromoReport(int storeId, List<PromoModel> promos) async {
    final token = await SharedPrefHelper.getToken();

    try {
      final response = await _dio.post(
        "${APIConstant.baseUrl}/report/promo",
        options: Options(headers: {"Authorization": "Bearer $token"}),
        data: {
          "store_id": storeId,
          "data": promos.map((p) => p.toJson()).toList(),
        },
      );

      if (response.data["status"] == "success") {
        return true;
      }
      return false;
    } catch (e) {
      throw Exception("Gagal submit promo: $e");
    }
  }
}