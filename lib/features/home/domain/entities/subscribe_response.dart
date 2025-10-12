class SubscribeResponse {
  final bool success;
  final String? message;

  const SubscribeResponse({
    required this.success,
    this.message,
  });

  factory SubscribeResponse.fromJson(Map<String, dynamic> json) =>
      SubscribeResponse(
        success: json["success"] ?? false,
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
