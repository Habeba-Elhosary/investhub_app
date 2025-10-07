import 'package:investhub_app/core/error/exceptions.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:investhub_app/features/general/data/datasources/general_remote_datasource.dart';
import 'package:investhub_app/features/general/domain/entities/banks_response.dart';
import 'package:investhub_app/features/general/domain/entities/registration_questions_response.dart';
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
  Future<Either<Failure, BanksResponse>> getBanks() async {
    try {
      return right(await generalRemoteDataSource.getBanks());
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }

  @override
  Future<Either<Failure, RegistrationQuestionsResponse>>
  getRegistrationQuestions() async {
    try {
      return right(await generalRemoteDataSource.getRegistrationQuestions());
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }
}
