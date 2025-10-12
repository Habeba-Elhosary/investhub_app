class Opportunity {
  final int id;
  final String companyName;
  final String description;
  final String currentPrice;
  final String entryPrice;
  final String expectedReturnPercentage;
  final String market;
  final bool isHalal, isAmerican;
  final String marketName;
  final String sector;
  final String sectorName;
  final String? image;

  const Opportunity({
    required this.id,
    required this.companyName,
    required this.description,
    required this.currentPrice,
    required this.entryPrice,
    required this.expectedReturnPercentage,
    required this.market,
    required this.isHalal,
    required this.isAmerican,
    required this.marketName,
    required this.sector,
    required this.sectorName,
    this.image,
  });

  factory Opportunity.fromJson(Map<String, dynamic> json) => Opportunity(
    id: json["id"],
    companyName: json["company_name"],
    description: json["description"],
    currentPrice: json["current_price"],
    entryPrice: json["entry_price"],
    expectedReturnPercentage: json["expected_return_percentage"],
    market: json["market"],
    isHalal: json["is_halal"],
    isAmerican: json["is_american"] ?? false,
    marketName: json["market_name"],
    sector: json["sector"],
    sectorName: json["sector_name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_name": companyName,
    "description": description,
    "current_price": currentPrice,
    "entry_price": entryPrice,
    "expected_return_percentage": expectedReturnPercentage,
    "market": market,
    "is_halal": isHalal,
    "is_american": isAmerican,
    "market_name": marketName,
    "sector": sector,
    "sector_name": sectorName,
    "image": image,
  };
}

class OpportunitiesResponse {
  final bool success;
  final List<Opportunity> data;

  const OpportunitiesResponse({required this.success, required this.data});

  factory OpportunitiesResponse.fromJson(Map<String, dynamic> json) =>
      OpportunitiesResponse(
        success: json["success"],
        data: List<Opportunity>.from(
          json["data"].map((x) => Opportunity.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
