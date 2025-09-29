import 'package:investhub_app/core/enums/item_enum.dart';

class CartResponse {
  final num status;
  final List<CartData> data;
  // final num? total;

  const CartResponse({
    required this.status,
    required this.data,
    // required this.total,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      status: json["status"],
      data: json["data"] == null
          ? []
          : List<CartData>.from(json["data"]!.map((x) => CartData.fromJson(x))),
      // total: json["total"],
    );
  }
}

class CartData {
  final int itemId;
  final String title;
  final int quantity;
  final String image;
  final ItemType type;
  // final num? totalPrice;

  const CartData({
    required this.itemId,
    required this.title,
    required this.quantity,
    required this.image,
    required this.type,
    // required this.totalPrice,
  });

  CartData copyWith({
    int? itemId,
    int? quantity,
    String? title,
    String? image,
    ItemType? type,
    // num? totalPrice,
  }) {
    return CartData(
      title: title ?? this.title,
      itemId: itemId ?? this.itemId,
      quantity: quantity ?? this.quantity,
      image: image ?? this.image,
      type: type ?? this.type,
      // totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      title: json["title"],
      itemId: json["item_id"],
      quantity: json["quantity"],
      image: json["image"],
      type: getItemTypeFromString(json["type"]),
      // totalPrice: json["total"],
    );
  }
}
