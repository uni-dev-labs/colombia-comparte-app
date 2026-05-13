class UserModel {
  final String name;
  final String email;
  final String role;
  final String country;
  final String token;

  UserModel({
    required this.name,
    required this.email,
    required this.role,
    required this.country,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      role: json['role'],
      country: json['country'],
      token: json['token'],
    );
  }
}