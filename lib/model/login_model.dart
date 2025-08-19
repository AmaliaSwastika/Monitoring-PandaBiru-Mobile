class LoginModel {
  final int id;
  final String username;
  final String email;
  final String token;

  LoginModel({
    required this.id,
    required this.username,
    required this.email,
    required this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      token: json['token'],
    );
  }
}
