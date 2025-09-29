import 'package:investhub_app/core/entities/pagination_response.dart';

class OrdersResponse extends PaginationResponse {
  final List<OrderData> data;

  OrdersResponse({
    required this.data,
    required super.status,
    required super.links,
    required super.meta,
  });

  factory OrdersResponse.fromJson(Map<String, dynamic> json) {
    return OrdersResponse(
      data: json["data"] == null
          ? []
          : List<OrderData>.from(
              json["data"]!.map((x) => OrderData.fromJson(x)),
            ),
      status: json["status"],
      meta: Meta.fromJson(json["meta"]),
      links: Links.fromJson(json["links"]),
    );
  }
}

class OrderData {
  final int id;
  final String serialNumber;
  final String status;
  // final int total;
  final DateTime createdAt;

  const OrderData({
    required this.id,
    required this.serialNumber,
    required this.status,
    // required this.total,
    required this.createdAt,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      id: json["id"],
      serialNumber: json["serial_number"],
      status: json["status"],
      // total: json["total"],
      createdAt: DateTime.parse(json["created_at"]),
    );
  }
}
