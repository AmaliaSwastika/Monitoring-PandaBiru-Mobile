import 'package:dio/dio.dart';
import 'package:panda_biru/helper/shared_preferences.dart';
import 'package:panda_biru/model/product_shop_model.dart';
import 'package:panda_biru/services/secret/constant.dart';

class ProductAPI {
  final Dio _dio = Dio();

  Future<bool> submitProductReport(int storeId, List<ProductModel> products) async {
    final token = await SharedPrefHelper.getToken();

    if (token == null) {
      throw Exception("Token tidak ditemukan. Silakan login ulang.");
    }

    // ignore: prefer_const_declarations
    final url = "${APIConstant.baseUrl}/report/product";

    final body = {
      "store_id": storeId,
      "data": {
        "data": products.map((e) => e.toJson()).toList(),
      }
    };

    try {
      final response = await _dio.post(
        url,
        data: body,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data["status"] == "success";
      } else {
        throw Exception("Gagal submit product: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.response?.data ?? e.message}");
    }
  }
}