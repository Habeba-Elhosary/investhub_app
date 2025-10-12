import 'package:dartz/dartz.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/features/auth/data/models/auth_response.dart';
import 'package:investhub_app/features/home/domain/entities/edit_profile_params.dart';

abstract class EditProfileRepository {
  Future<Either<Failure, AuthResponse>> editProfile(EditProfileParams params);
}
