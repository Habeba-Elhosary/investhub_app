import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/features/auth/data/models/detect_user_response.dart';
import 'package:investhub_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class DetectUserByPhoneUsecase extends UseCase<DetectUserResponse, String> {
  final AuthRepository repository;

  DetectUserByPhoneUsecase({required this.repository});

  @override
  Future<Either<Failure, DetectUserResponse>> call(String params) async {
    return await repository.detectUser(params);
  }
}
