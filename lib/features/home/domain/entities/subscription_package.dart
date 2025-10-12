class SubscriptionPackage {
  final int id;
  final String name;
  final String description;
  final String durationType;
  final int durationMonths;
  final String durationName;
  final String price;
  final String formattedPrice;
  final String currency;
  final bool isPopular;
  final bool isSubscribed;
  final List<String>? features;

  const SubscriptionPackage({
    required this.id,
    required this.name,
    required this.description,
    required this.durationType,
    required this.durationMonths,
    required this.durationName,
    required this.price,
    required this.formattedPrice,
    required this.currency,
    required this.isPopular,
    required this.isSubscribed,
    required this.features,
  });

  factory SubscriptionPackage.fromJson(Map<String, dynamic> json) =>
      SubscriptionPackage(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        durationType: json["duration_type"],
        durationMonths: json["duration_months"],
        durationName: json["duration_name"],
        price: json["price"],
        formattedPrice: json["formatted_price"],
        currency: json["currency"],
        isPopular: json["is_popular"],
        isSubscribed: json["is_subscribed"] ?? false,
        features: json["features"] != null
            ? List<String>.from(json["features"].map((x) => x))
            : null,
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "duration_type": durationType,
    "duration_months": durationMonths,
    "duration_name": durationName,
    "price": price,
    "formatted_price": formattedPrice,
    "currency": currency,
    "is_popular": isPopular,
    "is_subscribed": isSubscribed,
    "features": features != null
        ? List<dynamic>.from(features!.map((x) => x))
        : null,
  };
}

class SubscriptionsResponse {
  final bool success;
  final List<SubscriptionPackage> data;

  const SubscriptionsResponse({required this.success, required this.data});

  factory SubscriptionsResponse.fromJson(Map<String, dynamic> json) =>
      SubscriptionsResponse(
        success: json["success"],
        data: List<SubscriptionPackage>.from(
          json["data"].map((x) => SubscriptionPackage.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
