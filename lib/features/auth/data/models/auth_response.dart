import 'dart:convert';

class AuthResponse {
  AuthResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  final UserData data;
  final String? message;
  final num? status;

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      data: UserData.fromJson(json["data"]),
      message: json["message"],
      status: json["status"],
    );
  }
}

class UserData {
  UserData({required this.accessToken, required this.user});

  final String accessToken;
  final User user;

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      accessToken: json["access_token"],
      user: User.fromJson(json["user"]),
    );
  }
}

class User {
  User({required this.id, required this.name, required this.phone});

  final int? id;
  final String name;
  final String phone;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json["id"], name: json["name"], phone: json["phone"]);
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {"id": id, "name": name, "phone": phone};
}
