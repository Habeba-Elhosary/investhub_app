import 'package:investhub_app/core/entities/pagination_response.dart';
import 'package:investhub_app/features/orders/data/models/orders_details_response.dart';

class AllOffersResponse extends PaginationResponse {
  final List<OfferSummary> data;

  AllOffersResponse({
    required this.data,
    required super.links,
    required super.meta,
    required super.status,
  });

  factory AllOffersResponse.fromJson(Map<String, dynamic> json) =>
      AllOffersResponse(
        data: List<OfferSummary>.from(
          json["data"].map((x) => OfferSummary.fromJson(x)),
        ),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
        status: json["status"],
      );
}

class OfferSummary {
  final int id;
  final String title;
  final String image;
  final String description;

  const OfferSummary({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
  });

  factory OfferSummary.fromJson(Map<String, dynamic> json) => OfferSummary(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "description": description,
  };
}

class Offer {
  final int id;
  final String title;
  final String description;
  final String image;
  final List<OrderItem> products;

  const Offer({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.products,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    products: List<OrderItem>.from(
      json["products"].map((x) => OrderItem.fromJson(x)),
    ),
  );
}
