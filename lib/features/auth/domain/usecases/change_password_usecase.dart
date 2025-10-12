import 'package:dartz/dartz.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/features/auth/domain/entities/change_password_params.dart';
import 'package:investhub_app/features/auth/domain/repositories/auth_repository.dart';

class ChangePasswordUsecase extends UseCase<String, ChangePasswordParams> {
  final AuthRepository repository;

  ChangePasswordUsecase({required this.repository});

  @override
  Future<Either<Failure, String>> call(ChangePasswordParams params) =>
      repository.changePassword(params: params);
}
