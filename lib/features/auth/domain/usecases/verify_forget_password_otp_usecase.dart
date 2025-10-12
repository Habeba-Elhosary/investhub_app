import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/auth_repository.dart';

class VerifyForgetPasswordOtpUsecase
    extends UseCase<String, VerifyForgetPasswordOtpParams> {
  final AuthRepository authRepository;

  VerifyForgetPasswordOtpUsecase({required this.authRepository});

  @override
  Future<Either<Failure, String>> call(VerifyForgetPasswordOtpParams params) =>
      authRepository.verifyForgetPasswordOTP(
        phone: params.phone,
        otp: params.otp,
        otpToken: params.otpToken,
      );
}

class VerifyForgetPasswordOtpParams {
  final String phone;
  final String otp;
  final String otpToken;

  VerifyForgetPasswordOtpParams({
    required this.phone,
    required this.otp,
    required this.otpToken,
  });
}
