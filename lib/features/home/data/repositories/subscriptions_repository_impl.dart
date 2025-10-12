import 'package:dartz/dartz.dart';
import 'package:investhub_app/core/error/exceptions.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:investhub_app/features/home/data/datasources/subscriptions_remote_datasource.dart';
import 'package:investhub_app/features/home/domain/entities/subscription_package.dart';
import 'package:investhub_app/features/home/domain/entities/subscribe_response.dart';
import 'package:investhub_app/features/home/domain/repositories/subscriptions_repository.dart';

class SubscriptionsRepositoryImpl implements SubscriptionsRepository {
  final SubscriptionsRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  SubscriptionsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, SubscriptionsResponse>> getSubscriptions() async {
    try {
      final SubscriptionsResponse response = await remoteDataSource
          .getSubscriptions();
      return right(response);
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }

  @override
  Future<Either<Failure, SubscribeResponse>> subscribe({
    required int subscriptionId,
  }) async {
    try {
      final token = await localDataSource.getUserAccessToken();
      final SubscribeResponse response = await remoteDataSource.subscribe(
        subscriptionId: subscriptionId,
        token: token,
      );

      if (response.success) {
        try {
          final currentUser = await localDataSource.getCacheUser();
          final updatedUser = currentUser.copyWith(isSubscribed: true);
          await localDataSource.cacheUser(updatedUser);
        } catch (e) {
          print('Error updating cached user subscription status: $e');
        }
      }

      return right(response);
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }
}
