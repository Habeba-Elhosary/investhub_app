import 'package:investhub_app/core/entities/status_response.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/auth_repository.dart';

class LogoutUsecase extends UseCase<StatusResponse, NoParams> {
  final AuthRepository authRepository;
  LogoutUsecase({required this.authRepository});

  @override
  Future<Either<Failure, StatusResponse>> call(NoParams params) =>
      authRepository.logout();
}
