import 'package:dartz/dartz.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/features/home/domain/entities/opportunity.dart';

abstract class OpportunitiesRepository {
  Future<Either<Failure, OpportunitiesResponse>> getOpportunities({
    int page = 1,
  });
}
