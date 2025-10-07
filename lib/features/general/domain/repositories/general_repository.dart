import 'package:investhub_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:investhub_app/features/general/domain/entities/banks_response.dart';
import 'package:investhub_app/features/general/domain/entities/registration_questions_response.dart';

abstract class GeneralRepository {
  Future<Either<Failure, BanksResponse>> getBanks();
  Future<Either<Failure, RegistrationQuestionsResponse>>
  getRegistrationQuestions();
}
