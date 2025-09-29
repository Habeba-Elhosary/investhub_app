import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/features/auth/data/models/auth_response.dart';
import 'package:investhub_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class RegisterUsecase extends UseCase<AuthResponse, RegisterParams> {
  final AuthRepository authRepository;
  RegisterUsecase({required this.authRepository});

  @override
  Future<Either<Failure, AuthResponse>> call(RegisterParams params) =>
      authRepository.register(params: params);
}
