import 'package:investhub_app/core/entities/pagination_response.dart';

class AllDepartmentsResponse extends PaginationResponse {
  final List<Department> data;

  AllDepartmentsResponse({
    required this.data,
    required super.links,
    required super.meta,
    required super.status,
  });

  factory AllDepartmentsResponse.fromJson(Map<String, dynamic> json) =>
      AllDepartmentsResponse(
        data: List<Department>.from(
          json["data"].map((x) => Department.fromJson(x)),
        ),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
        status: json["status"],
      );
}

class Department {
  final int id;
  final String name;
  final String image;
  final String type;

  Department({
    required this.id,
    required this.name,
    required this.image,
    required this.type,
  });

  factory Department.fromJson(Map<String, dynamic> json) => Department(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "type": type,
  };
}
