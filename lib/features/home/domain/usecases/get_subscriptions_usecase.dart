import 'package:dartz/dartz.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/features/home/domain/entities/subscription_package.dart';
import 'package:investhub_app/features/home/domain/repositories/subscriptions_repository.dart';

class GetSubscriptionsUsecase extends UseCase<SubscriptionsResponse, NoParams> {
  final SubscriptionsRepository repository;

  GetSubscriptionsUsecase({required this.repository});

  @override
  Future<Either<Failure, SubscriptionsResponse>> call(NoParams params) =>
      repository.getSubscriptions();
}
