import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/auth_repository.dart';

class ResetPasswordUsecase extends UseCase<String, ResetPasswordParams> {
  final AuthRepository authRepository;

  ResetPasswordUsecase({required this.authRepository});

  @override
  Future<Either<Failure, String>> call(ResetPasswordParams params) =>
      authRepository.resetPassword(
        phone: params.phone,
        password: params.password,
        resetToken: params.resetToken,
      );
}

class ResetPasswordParams {
  final String phone;
  final String password;
  final String resetToken;

  ResetPasswordParams({
    required this.phone,
    required this.password,
    required this.resetToken,
  });
}
