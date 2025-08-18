class PromoModel {
  String product;
  int normalPrice;
  int promoPrice;

  PromoModel({
    required this.product,
    required this.normalPrice,
    required this.promoPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      "product": product,
      "normal_price": normalPrice,
      "promo_price": promoPrice,
    };
  }
}
