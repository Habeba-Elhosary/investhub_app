class DetectUserResponse {
  final DetectUser data;
  final int status;

  DetectUserResponse({required this.data, required this.status});

  factory DetectUserResponse.fromJson(Map<String, dynamic> json) {
    return DetectUserResponse(
      data: DetectUser.fromJson(json["data"]),
      status: json["status"],
    );
  }
}

class DetectUser {
  final int id;
  final String name;
  final String phone;
  final bool isActive;
  final String token;
  DetectUser({
    required this.token,
    required this.id,
    required this.name,
    required this.phone,
    required this.isActive,
  });

  factory DetectUser.fromJson(Map<String, dynamic> json) {
    return DetectUser(
      id: json["id"],
      name: json["name"],
      phone: json["phone"],
      isActive: json["is_active"],
      token: json["token"],
    );
  }
}
