import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investhub_app/features/general/domain/entities/registration_questions_response.dart';
import 'package:investhub_app/features/general/domain/usecases/get_registration_questions_usecase.dart';
part 'registration_questions_state.dart';

class RegistrationQuestionsCubit extends Cubit<RegistrationQuestionsState> {
  final GetRegistrationQuestionsUsecase questionsUsecase;
  RegistrationQuestionsCubit({required this.questionsUsecase})
    : super(RegistrationQuestionsInitial());

  Future<void> getRegistrationQuestions() async {
    emit(RegistrationQuestionsLoading());
    final Either<Failure, RegistrationQuestionsResponse> result =
        await questionsUsecase(NoParams());
    result.fold(
      (Failure fail) {
        emit(RegistrationQuestionsError(message: fail.message));
      },
      (RegistrationQuestionsResponse response) {
        emit(RegistrationQuestionsLoaded(questions: response.data));
      },
    );
  }
}
