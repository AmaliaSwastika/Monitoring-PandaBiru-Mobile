class ActivityResponse {
  final String status;
  final List<ActivitySummary> summary;

  ActivityResponse({required this.status, required this.summary});

  factory ActivityResponse.fromJson(Map<String, dynamic> json) {
    return ActivityResponse(
      status: json['status'] ?? '',
      summary: (json['summary'] as List<dynamic>? ?? [])
          .map((e) => ActivitySummary.fromJson(e))
          .toList(),
    );
  }
}

class ActivitySummary {
  final int userId;
  final String username;
  final String email;
  final String date;
  final List<AttendanceData>? attendanceData;
  final List<StoreData> stores;

  ActivitySummary({
    required this.userId,
    required this.username,
    required this.email,
    required this.date,
    this.attendanceData,
    required this.stores,
  });

  factory ActivitySummary.fromJson(Map<String, dynamic> json) {
    return ActivitySummary(
      userId: json['user_id'] ?? 0,
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      date: json['date'] ?? '',
      attendanceData: json['attendance_data'] != null
          ? (json['attendance_data'] as List<dynamic>)
              .map((e) => AttendanceData.fromJson(e))
              .toList()
          : null,
      stores: (json['stores'] as List<dynamic>? ?? [])
          .map((e) => StoreData.fromJson(e))
          .toList(),
    );
  }
}

class AttendanceData {
  final AttendanceDetail data;
  final String createdAt;

  AttendanceData({required this.data, required this.createdAt});

  factory AttendanceData.fromJson(Map<String, dynamic> json) {
    return AttendanceData(
      data: AttendanceDetail.fromJson(json['data'] ?? {}),
      createdAt: json['created_at'] ?? '',
    );
  }
}

class AttendanceDetail {
  final String status;
  final String note;

  AttendanceDetail({required this.status, required this.note});

  factory AttendanceDetail.fromJson(Map<String, dynamic> json) {
    return AttendanceDetail(
      status: json['status'] ?? '',
      note: json['note'] ?? '',
    );
  }
}

class StoreData {
  final int storeId;
  final String storeName;
  final String storeCode;
  final String storeAddress;
  final List<ProductData> products;
  final List<PromoData> promos;

  StoreData({
    required this.storeId,
    required this.storeName,
    required this.storeCode,
    required this.storeAddress,
    required this.products,
    required this.promos,
  });

  factory StoreData.fromJson(Map<String, dynamic> json) {
    return StoreData(
      storeId: json['store_id'] ?? 0,
      storeName: json['store_name'] ?? '',
      storeCode: json['store_code'] ?? '',
      storeAddress: json['store_address'] ?? '',
      products: (json['products'] as List<dynamic>? ?? [])
          .map((e) => ProductData.fromJson(e))
          .toList(),
      promos: (json['promos'] as List<dynamic>? ?? [])
          .map((e) => PromoData.fromJson(e))
          .toList(),
    );
  }
}

class ProductData {
  final String product;
  final String? barcode; // bisa null
  final bool available;
  final String createdAt;

  ProductData({
    required this.product,
    this.barcode,
    required this.available,
    required this.createdAt,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      product: json['product'] ?? '',
      barcode: json['barcode'], // nullable
      available: json['available'] ?? false,
      createdAt: json['created_at'] ?? '',
    );
  }
}

class PromoData {
  final String product;
  final int normalPrice;
  final int promoPrice;
  final String createdAt;

  PromoData({
    required this.product,
    required this.normalPrice,
    required this.promoPrice,
    required this.createdAt,
  });

  factory PromoData.fromJson(Map<String, dynamic> json) {
    return PromoData(
      product: json['product'] ?? '',
      normalPrice: json['normal_price'] ?? 0,
      promoPrice: json['promo_price'] ?? 0,
      createdAt: json['created_at'] ?? '',
    );
  }
}
