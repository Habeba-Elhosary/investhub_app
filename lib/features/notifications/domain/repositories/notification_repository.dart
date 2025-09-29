import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/features/home/domain/repositories/home_repository.dart';
import 'package:investhub_app/features/notifications/domain/entities/notification_response.dart';
import 'package:dartz/dartz.dart';

abstract class NotificationsRepository {
  Future<Either<Failure, AllNotificationsResponse>> getAllNotifications({
    required PaginationParams params,
  });
  Future<Either<Failure, Unit>> markAllNotificationsAsRead();
  Future<Either<Failure, int>> getUnreadNotificationsCount();
}
