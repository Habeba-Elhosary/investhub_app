import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/features/general/domain/entities/registration_questions_response.dart';
import 'package:investhub_app/features/general/domain/repositories/general_repository.dart';
import 'package:dartz/dartz.dart';

class GetRegistrationQuestionsUsecase
    extends UseCase<RegistrationQuestionsResponse, NoParams> {
  final GeneralRepository generalRepository;
  GetRegistrationQuestionsUsecase({required this.generalRepository});

  @override
  Future<Either<Failure, RegistrationQuestionsResponse>> call(
    NoParams params,
  ) => generalRepository.getRegistrationQuestions();
}
