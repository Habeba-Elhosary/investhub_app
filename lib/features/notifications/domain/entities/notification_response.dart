import 'package:investhub_app/core/entities/pagination_response.dart';
import 'package:investhub_app/core/enums/notification_type_enum.dart';

class AllNotificationsResponse extends PaginationResponse {
  final List<NotificationEntity> data;
  AllNotificationsResponse({
    required this.data,
    required super.status,
    required super.links,
    required super.meta,
  });

  factory AllNotificationsResponse.fromJson(Map<String, dynamic> json) {
    return AllNotificationsResponse(
      links: Links.fromJson(json["links"]),
      meta: Meta.fromJson(json["meta"]),
      status: json["status"],
      data: json["data"] == null
          ? []
          : List<NotificationEntity>.from(
              json["data"]!.map((x) => NotificationEntity.fromJson(x)),
            ),
    );
  }
}

class NotificationEntity {
  final String id;
  final Data data;
  final bool isSeen;
  final DateTime createdAt;

  NotificationEntity({
    required this.id,
    required this.data,
    required this.isSeen,
    required this.createdAt,
  });

  NotificationEntity copyWith({
    String? id,
    Data? data,
    bool? isSeen,
    DateTime? createdAt,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      data: data ?? this.data,
      isSeen: isSeen ?? this.isSeen,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory NotificationEntity.fromJson(Map<String, dynamic> json) {
    return NotificationEntity(
      id: json["id"],
      data: Data.fromJson(json["data"]),
      isSeen: json["is_seen"],
      createdAt: DateTime.parse(json["created_at"]),
    );
  }
}

class Data {
  final String title;
  final String body;
  final String? type;
  final NotificationType? notificationType;
  final int? id;

  Data({
    required this.title,
    required this.body,
    required this.type,
    required this.notificationType,
    required this.id,
  });

  Data copyWith({
    String? title,
    String? body,
    String? type,
    NotificationType? notificationType,
    int? id,
  }) {
    return Data(
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      notificationType: notificationType ?? this.notificationType,
      id: id ?? this.id,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      title: json["title"],
      body: json["body"],
      type: json["type"],
      notificationType: getNotificationTypeFromString(
        json["notification_type"],
      ),
      id: json["id"],
    );
  }
}
