// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

UserResponse userResponseFromJson(String str) => UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
    bool ok;
    String message;
    User user;
    String token;

    UserResponse({
        required this.ok,
        required this.message,
        required this.user,
        required this.token,
    });

    factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        ok: json["ok"],
        message: json["message"],
        user: User.fromJson(json["user"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "message": message,
        "user": user.toJson(),
        "token": token,
    };
}

class User {
    String id;
    String name;
    String email;
    String phone;
    DateTime createdAt;
    DateTime updatedAt;
    String uid;

    User({
        required this.id,
        required this.name,
        required this.email,
        required this.phone,
        required this.createdAt,
        required this.updatedAt,
        required this.uid,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        createdAt: DateTime.parse(json["CreatedAt"]),
        updatedAt: DateTime.parse(json["UpdatedAt"]),
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "CreatedAt": createdAt.toIso8601String(),
        "UpdatedAt": updatedAt.toIso8601String(),
        "uid": uid,
    };
}
