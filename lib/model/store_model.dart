class StoreModel {
  final int id;
  final String name;
  final String code;
  final String address;

  StoreModel({
    required this.id,
    required this.name,
    required this.code,
    required this.address,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      address: json['address'],
    );
  }
}
