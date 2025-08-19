class ProductModel {
  final String product;
  final String barcode;
  bool available; 

  ProductModel({
    required this.product,
    required this.barcode,
    this.available = false,
  });

  Map<String, dynamic> toJson() {
    return {
      "product": product,
      "barcode": barcode,
      "available": available,
    };
  }
}
