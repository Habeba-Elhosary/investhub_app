import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/features/auth/data/models/auth_response.dart';
import 'package:investhub_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AutoLoginUsecase extends UseCase<User, NoParams> {
  final AuthRepository authRepository;

  AutoLoginUsecase({required this.authRepository});
  @override
  Future<Either<Failure, User>> call(NoParams params) =>
      authRepository.autoLogin();
}
