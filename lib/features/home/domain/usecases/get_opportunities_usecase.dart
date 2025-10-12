import 'package:dartz/dartz.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/features/home/domain/entities/opportunity.dart';
import 'package:investhub_app/features/home/domain/repositories/opportunities_repository.dart';

class GetOpportunitiesUsecase extends UseCase<OpportunitiesResponse, int> {
  final OpportunitiesRepository repository;

  GetOpportunitiesUsecase({required this.repository});

  @override
  Future<Either<Failure, OpportunitiesResponse>> call(int page) =>
      repository.getOpportunities(page: page);
}
