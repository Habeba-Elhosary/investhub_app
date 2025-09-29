import 'package:investhub_app/features/auth/data/models/auth_response.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/auth_repository.dart';

class LoginUsecase extends UseCase<AuthResponse, LoginParams> {
  final AuthRepository authRepository;
  LoginUsecase({required this.authRepository});

  @override
  Future<Either<Failure, AuthResponse>> call(LoginParams params) =>
      authRepository.login(phone: params.phone, password: params.password);
}

class LoginParams {
  final String phone;
  final String password;

  LoginParams({required this.phone, required this.password});
}
