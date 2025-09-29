import 'package:investhub_app/features/auth/data/models/auth_response.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/auth_repository.dart';

class GetUserProfileUsecase extends UseCase<AuthResponse, NoParams> {
  final AuthRepository authRepository;

  GetUserProfileUsecase({required this.authRepository});

  @override
  Future<Either<Failure, AuthResponse>> call(NoParams params) =>
      authRepository.getUserProfile();
}
