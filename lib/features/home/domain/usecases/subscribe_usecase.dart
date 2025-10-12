import 'package:dartz/dartz.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/features/home/domain/entities/subscribe_response.dart';
import 'package:investhub_app/features/home/domain/repositories/subscriptions_repository.dart';

class SubscribeUsecase {
  final SubscriptionsRepository repository;
  
  SubscribeUsecase({required this.repository});

  Future<Either<Failure, SubscribeResponse>> call({required int subscriptionId}) =>
      repository.subscribe(subscriptionId: subscriptionId);
}

class SubscribeParams {
  final int subscriptionId;

  const SubscribeParams({required this.subscriptionId});
}
