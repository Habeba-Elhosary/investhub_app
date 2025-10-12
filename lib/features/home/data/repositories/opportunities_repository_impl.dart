import 'package:dartz/dartz.dart';
import 'package:investhub_app/core/error/exceptions.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/features/home/data/datasources/opportunities_remote_datasource.dart';
import 'package:investhub_app/features/home/domain/entities/opportunity.dart';
import 'package:investhub_app/features/home/domain/repositories/opportunities_repository.dart';

class OpportunitiesRepositoryImpl implements OpportunitiesRepository {
  final OpportunitiesRemoteDataSource remoteDataSource;

  OpportunitiesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, OpportunitiesResponse>> getOpportunities({
    int page = 1,
  }) async {
    try {
      final OpportunitiesResponse response = await remoteDataSource
          .getOpportunities(page: page);
      return right(response);
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }
}
