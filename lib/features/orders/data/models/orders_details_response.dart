import 'package:investhub_app/core/enums/item_enum.dart';
import 'package:investhub_app/core/enums/order_type_enum.dart';

class OrderDetailsResponse {
  final OrderDetailsData data;
  final num status;
  OrderDetailsResponse({required this.data, required this.status});

  factory OrderDetailsResponse.fromJson(Map<String, dynamic> json) {
    return OrderDetailsResponse(
      data: OrderDetailsData.fromJson(json["data"]),
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {"data": data.toJson(), "status": status};
}

class OrderDetailsData {
  final int id;
  final String serialNumber;
  final OrderType status;
  final List<OrderItem> products;
  // final num total;

  const OrderDetailsData({
    required this.id,
    required this.serialNumber,
    required this.status,
    required this.products,
    // required this.total,
  });

  factory OrderDetailsData.fromJson(Map<String, dynamic> json) {
    return OrderDetailsData(
      id: json["id"],
      serialNumber: json["serial_number"],
      status: getOrderTypeFromString(json["status"]),
      products: json["items"] == null
          ? []
          : List<OrderItem>.from(
              json["items"]!.map((x) => OrderItem.fromJson(x)),
              // total: json["total"],
            ),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "serial_number": serialNumber,
    "status": status,
    "items": products.map((x) => x.toJson()).toList(),
    // "total": total,
  };
}

class OrderItem {
  final int id;
  final String name;
  final String image;
  final ItemType type;
  final num quantity;
  // final num price;

  const OrderItem({
    required this.id,
    required this.name,
    required this.image,
    required this.type,
    required this.quantity,
    // required this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json["id"],
      name: json["name"],
      image: json["image"],
      type: getItemTypeFromString(json["type"]),
      quantity: json["quantity"],
      // price: json["price"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "type": type,
    "quantity": quantity,
    // "price": price,
  };
}
