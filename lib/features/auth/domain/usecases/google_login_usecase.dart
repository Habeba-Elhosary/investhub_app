import 'package:investhub_app/features/auth/data/models/auth_response.dart';
import 'package:dartz/dartz.dart';
import 'package:investhub_app/features/auth/presentation/cubits/google_login/google_login_cubit.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/auth_repository.dart';

class GoogleLoginUsecase extends UseCase<AuthResponse, GoogleLoginParams> {
  final AuthRepository authRepository;
  GoogleLoginUsecase({required this.authRepository});

  @override
  Future<Either<Failure, AuthResponse>> call(GoogleLoginParams params) =>
      authRepository.googleLogin(socialCredentials: params.socialCredentials);
}

class GoogleLoginParams {
  final SocialCredentials socialCredentials;

  GoogleLoginParams({required this.socialCredentials});
}
