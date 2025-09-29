import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/auth_repository.dart';

class VerifyCodeUsecase extends UseCase<Unit, String> {
  final AuthRepository authRepository;

  VerifyCodeUsecase({required this.authRepository});

  @override
  Future<Either<Failure, Unit>> call(String params) =>
      authRepository.verifyCode(params);
}
