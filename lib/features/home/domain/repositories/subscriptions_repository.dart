import 'package:dartz/dartz.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/features/home/domain/entities/subscription_package.dart';
import 'package:investhub_app/features/home/domain/entities/subscribe_response.dart';

abstract class SubscriptionsRepository {
  Future<Either<Failure, SubscriptionsResponse>> getSubscriptions();
  Future<Either<Failure, SubscribeResponse>> subscribe({
    required int subscriptionId,
  });
}
