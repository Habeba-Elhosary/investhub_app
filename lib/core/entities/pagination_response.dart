abstract class PaginationResponse {
  final Links links;
  final Meta meta;
  final int status;

  PaginationResponse({
    required this.links,
    required this.meta,
    required this.status,
  });
}

class Links {
  final String first;
  final String last;
  final dynamic prev;
  final dynamic next;

  Links({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json['first'],
        last: json['last'],
        prev: json['prev'],
        next: json['next'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'first': first,
        'last': last,
        'prev': prev,
        'next': next,
      };
}

class Meta {
  final int currentPage;
  final int? from;
  final int lastPage;
  final List<Link> links;
  final String path;
  final int perPage;
  final int? to;
  final int total;

  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json['current_page'],
        from: json['from'],
        lastPage: json['last_page'],
        links: List<Link>.from(json['links'].map((x) => Link.fromJson(x))),
        path: json['path'],
        perPage: json['per_page'],
        to: json['to'],
        total: json['total'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'current_page': currentPage,
        'from': from,
        'last_page': lastPage,
        'links': List<dynamic>.from(links.map((Link x) => x.toJson())),
        'path': path,
        'per_page': perPage,
        'to': to,
        'total': total,
      };
}

class Link {
  final String? url;
  final String label;
  final bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json['url'],
        label: json['label'],
        active: json['active'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'url': url,
        'label': label,
        'active': active,
      };
}
