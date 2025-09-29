import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/auth_repository.dart';

class CreateNewPasswordUsecase extends UseCase<Unit, CreateNewPasswordParams> {
  final AuthRepository authRepository;
  CreateNewPasswordUsecase({required this.authRepository});

  @override
  Future<Either<Failure, Unit>> call(CreateNewPasswordParams params) =>
      authRepository.createNewPassword(
        password: params.password,
        passwordConfirmation: params.password,
      );
}

class CreateNewPasswordParams {
  final String password;
  final String confirmationPassword;

  CreateNewPasswordParams({
    required this.confirmationPassword,
    required this.password,
  });
}
