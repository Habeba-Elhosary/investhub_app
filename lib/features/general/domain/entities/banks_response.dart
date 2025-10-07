import 'package:investhub_app/core/widgets/single_drop_down_selector.dart';

class BanksResponse {
  final int status;
  final String? message;
  final List<Bank> data;

  BanksResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BanksResponse.fromJson(Map<String, dynamic> json) => BanksResponse(
    status: json["status"],
    message: json["message"],
    data: List<Bank>.from(json["data"].map((x) => Bank.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Bank extends BaseSelectableEntity {
  const Bank({required super.id, required super.name});

  factory Bank.fromJson(Map<String, dynamic> json) =>
      Bank(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
