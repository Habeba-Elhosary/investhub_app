part of 'registration_questions_cubit.dart';

sealed class RegistrationQuestionsState extends Equatable {
  const RegistrationQuestionsState();

  @override
  List<Object> get props => [];
}

final class RegistrationQuestionsInitial extends RegistrationQuestionsState {}

final class RegistrationQuestionsLoading extends RegistrationQuestionsState {}

final class RegistrationQuestionsLoaded extends RegistrationQuestionsState {
  final List<Question> questions;
  const RegistrationQuestionsLoaded({required this.questions});
}

final class RegistrationQuestionsError extends RegistrationQuestionsState {
  final String message;
  const RegistrationQuestionsError({required this.message});
}
