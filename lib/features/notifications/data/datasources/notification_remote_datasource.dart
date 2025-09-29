import 'package:investhub_app/core/util/api_base_helper.dart';
import 'package:investhub_app/features/home/domain/repositories/home_repository.dart';
import 'package:investhub_app/features/notifications/domain/entities/notification_response.dart';
import 'package:dartz/dartz.dart';

const String allNotificationsAPI = '/auth/notification/show';
const String unreadNotificationsAPI = '/auth/notification/unread';
const String markAllNotificationsAsReadAPI = '/auth/notification/mark-as-read';

abstract class NotificationsRemoteDatasource {
  Future<AllNotificationsResponse> getAllNotifications({
    required PaginationParams params,
    required String token,
  });
  Future<int> getUnreadNotificationsCount(String token);
  Future<Unit> markAllNotificationsAsRead(String token);
}

class NotificationsRemoteDatasourceImpl
    implements NotificationsRemoteDatasource {
  final ApiBaseHelper apiBaseHelper;
  NotificationsRemoteDatasourceImpl({required this.apiBaseHelper});

  @override
  Future<AllNotificationsResponse> getAllNotifications({
    required PaginationParams params,
    required String token,
  }) async {
    try {
      final dynamic response = await apiBaseHelper.get(
        url: allNotificationsAPI,
        queryParameters: params.toJson(),
        token: token,
      );
      return AllNotificationsResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> getUnreadNotificationsCount(String token) async {
    try {
      final dynamic response = await apiBaseHelper.get(
        url: unreadNotificationsAPI,
        token: token,
      );
      return response['data']['unread_notifications'];
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Unit> markAllNotificationsAsRead(String token) async {
    try {
      await apiBaseHelper.get(url: markAllNotificationsAsReadAPI, token: token);
      return unit;
    } catch (error) {
      rethrow;
    }
  }
}
