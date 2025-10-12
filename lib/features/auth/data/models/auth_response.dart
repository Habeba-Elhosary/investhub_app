import 'dart:convert';

class AuthResponse {
  final User data;
  final String? message;
  final num? status;
  AuthResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      data: User.fromJson(json["data"]),
      message: json["message"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
    "status": status,
  };

  /// 🔹 تحويل الكائن إلى JSON String خام
  String toRawJson() => json.encode(toJson());
}

class UserData {
  UserData({required this.accessToken, required this.user});

  final String accessToken;
  final User user;

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      accessToken: json["token"] ?? '',
      user: User.fromJson(json["user"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "user": user.toJson(),
  };

  /// 🔹 تحويل الكائن إلى JSON String خام
  String toRawJson() => json.encode(toJson());
}

class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String nationalId;
  final DateTime dateOfBirth;
  final String maritalStatus;
  final int familyMembersCount;
  final String educationLevel;
  final String annualIncome;
  final String totalSavings;
  final String bank;
  final bool isActive, isSubscribed;
  final String otpToken;
  final bool otpVerified;
  final String token;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.nationalId,
    required this.dateOfBirth,
    required this.maritalStatus,
    required this.familyMembersCount,
    required this.educationLevel,
    required this.annualIncome,
    required this.totalSavings,
    required this.bank,
    required this.isActive,
    required this.isSubscribed,
    required this.otpToken,
    required this.otpVerified,
    required this.token,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    email: json["email"] ?? '',
    phone: json["phone"] ?? '',
    nationalId: json["national_id"] ?? '',
    dateOfBirth: DateTime.parse(
      json["date_of_birth"] ?? DateTime.now().toIso8601String(),
    ),
    maritalStatus: json["marital_status"] ?? '',
    familyMembersCount:
        int.tryParse(json["family_members_count"]?.toString() ?? '0') ?? 0,
    educationLevel: json["education_level"] ?? '',
    annualIncome: json["annual_income"] ?? '',
    totalSavings: json["total_savings"] ?? '',
    bank: json["bank"] ?? '',
    isActive: json["is_active"] ?? false,
    isSubscribed: json["is_subscribed"] ?? false,
    otpToken: json["otp_token"] ?? '',
    otpVerified: json["otp_verified"] ?? false,
    token: json["token"] ?? '',
    createdAt: DateTime.tryParse(json["created_at"] ?? '') ?? DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "national_id": nationalId,
    "date_of_birth":
        "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
    "marital_status": maritalStatus,
    "family_members_count": familyMembersCount,
    "education_level": educationLevel,
    "annual_income": annualIncome,
    "total_savings": totalSavings,
    "bank": bank,
    "is_active": isActive,
    "is_subscribed": isSubscribed,
    "otp_token": otpToken,
    "otp_verified": otpVerified,
    "token": token,
    "created_at": createdAt.toIso8601String(),
  };

  String toRawJson() => json.encode(toJson());

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? nationalId,
    DateTime? dateOfBirth,
    String? maritalStatus,
    int? familyMembersCount,
    String? educationLevel,
    String? annualIncome,
    String? totalSavings,
    String? bank,
    bool? isActive,
    bool? isSubscribed,
    String? otpToken,
    bool? otpVerified,
    String? token,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      nationalId: nationalId ?? this.nationalId,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      familyMembersCount: familyMembersCount ?? this.familyMembersCount,
      educationLevel: educationLevel ?? this.educationLevel,
      annualIncome: annualIncome ?? this.annualIncome,
      totalSavings: totalSavings ?? this.totalSavings,
      bank: bank ?? this.bank,
      isActive: isActive ?? this.isActive,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      otpToken: otpToken ?? this.otpToken,
      otpVerified: otpVerified ?? this.otpVerified,
      token: token ?? this.token,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
