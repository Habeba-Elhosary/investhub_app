import 'package:investhub_app/core/entities/pagination_response.dart';
import 'package:investhub_app/core/enums/item_enum.dart';

class AllProductsResponse extends PaginationResponse {
  List<Product> data;
  AllProductsResponse({
    required this.data,
    required super.meta,
    required super.links,
    required super.status,
  });

  factory AllProductsResponse.fromJson(Map<String, dynamic> json) {
    return AllProductsResponse(
      data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
      meta: Meta.fromJson(json["meta"]),
      links: Links.fromJson(json["links"]),
      status: json["status"],
    );
  }
}

class Product {
  final int id;
  final String name;
  final String image;
  final String description;
  // final num price;
  // final num? priceAfterDiscount;
  // final DateTime? discountStartDate;
  // final DateTime? discountEndDate;
  final String brand;
  final String department;
  final ItemType type;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    // required this.price,
    // required this.priceAfterDiscount,
    // required this.discountStartDate,
    // required this.discountEndDate,
    required this.brand,
    required this.department,
    required this.type,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    description: json["description"],
    // price: json["price"],
    // priceAfterDiscount: json["price_after_discount"],
    // discountStartDate:
    //     json["discount_start_date"] == null
    //         ? null
    //         : DateTime.parse(json["discount_start_date"]),
    // discountEndDate:
    //     json["discount_end_date"] == null
    //         ? null
    //         : DateTime.parse(json["discount_end_date"]),
    brand: json["brand"],
    department: json["category"],
    type: getItemTypeFromString(json["type"]),
  );
}
