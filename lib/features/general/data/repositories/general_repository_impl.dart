import 'package:investhub_app/core/entities/status_response.dart';
import 'package:investhub_app/core/error/exceptions.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:investhub_app/features/general/data/datasources/general_remote_datasource.dart';
import 'package:investhub_app/features/general/domain/repositories/general_repository.dart';
import 'package:dartz/dartz.dart';

class GeneralRepositoryImpl implements GeneralRepository {
  final GeneralRemoteDataSource generalRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  GeneralRepositoryImpl({
    required this.generalRemoteDataSource,
    required this.authLocalDataSource,
  });

  @override
  Future<Either<Failure, StatusResponse>> sendComplaint(String content) async {
    try {
      final String token = await authLocalDataSource.getUserAccessToken();
      return right(await generalRemoteDataSource.sendComplaint(content, token));
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }

  @override
  Future<Either<Failure, String>> getStaticData(String type) async {
    try {
      return right(await generalRemoteDataSource.getStaticData(type));
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }
}
