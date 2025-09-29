import 'package:investhub_app/core/error/exceptions.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:investhub_app/features/home/domain/repositories/home_repository.dart';
import 'package:investhub_app/features/notifications/data/datasources/notification_remote_datasource.dart';
import 'package:investhub_app/features/notifications/domain/entities/notification_response.dart';
import 'package:investhub_app/features/notifications/domain/repositories/notification_repository.dart';
import 'package:dartz/dartz.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsRemoteDatasource notificationsRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  NotificationsRepositoryImpl({
    required this.notificationsRemoteDataSource,
    required this.authLocalDataSource,
  });

  @override
  Future<Either<Failure, AllNotificationsResponse>> getAllNotifications({
    required PaginationParams params,
  }) async {
    try {
      final AllNotificationsResponse response =
          await notificationsRemoteDataSource.getAllNotifications(
            token: await authLocalDataSource.getUserAccessToken(),
            params: PaginationParams(page: params.page),
          );
      return right(response);
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }

  @override
  Future<Either<Failure, int>> getUnreadNotificationsCount() async {
    try {
      final String token = await authLocalDataSource.getUserAccessToken();
      final int data = await notificationsRemoteDataSource
          .getUnreadNotificationsCount(token);
      return right(data);
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    } on UnauthorizedException catch (_) {
      await authLocalDataSource.clearData();
      return left(UnauthorizedFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> markAllNotificationsAsRead() async {
    try {
      final String token = await authLocalDataSource.getUserAccessToken();

      final Unit data = await notificationsRemoteDataSource
          .markAllNotificationsAsRead(token);
      return right(data);
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }
}
