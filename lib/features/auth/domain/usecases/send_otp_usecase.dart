import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/auth_repository.dart';

class SendOtpUsecase extends UseCase<Unit, NoParams> {
  final AuthRepository authRepository;

  SendOtpUsecase({required this.authRepository});

  @override
  Future<Either<Failure, Unit>> call(NoParams params) =>
      authRepository.sendOTPCode();
}
