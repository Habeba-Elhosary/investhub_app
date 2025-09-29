import 'package:investhub_app/features/auth/data/models/auth_response.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/auth_repository.dart';

class ForgetPasswordUsecase extends UseCase<AuthResponse, PhoneParams> {
  final AuthRepository authRepository;

  ForgetPasswordUsecase({required this.authRepository});

  @override
  Future<Either<Failure, AuthResponse>> call(PhoneParams params) =>
      authRepository.forgetPassword(phone: params.phone);
}

class PhoneParams {
  final String phone;

  PhoneParams({required this.phone});
}
