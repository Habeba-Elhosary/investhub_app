import 'package:dartz/dartz.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/features/auth/data/models/auth_response.dart';
import 'package:investhub_app/features/home/domain/entities/edit_profile_params.dart';
import 'package:investhub_app/features/home/domain/repositories/edit_profile_repository.dart';

class EditProfileUsecase extends UseCase<AuthResponse, EditProfileParams> {
  final EditProfileRepository repository;

  EditProfileUsecase({required this.repository});

  @override
  Future<Either<Failure, AuthResponse>> call(EditProfileParams params) =>
      repository.editProfile(params);
}
