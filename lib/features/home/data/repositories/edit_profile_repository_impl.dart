import 'package:dartz/dartz.dart';
import 'package:investhub_app/core/error/exceptions.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:investhub_app/features/auth/data/models/auth_response.dart';
import 'package:investhub_app/features/home/data/datasources/edit_profile_remote_datasource.dart';
import 'package:investhub_app/features/home/domain/entities/edit_profile_params.dart';
import 'package:investhub_app/features/home/domain/repositories/edit_profile_repository.dart';

class EditProfileRepositoryImpl implements EditProfileRepository {
  final EditProfileRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  EditProfileRepositoryImpl({required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, AuthResponse>> editProfile(
    EditProfileParams params,
  ) async {
    try {
      final token = await localDataSource.getUserAccessToken();
      final AuthResponse response = await remoteDataSource.editProfile(params, token);
      return right(response);
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }
}
