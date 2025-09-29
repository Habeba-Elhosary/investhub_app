part of 'create_new_password_cubit.dart';

sealed class CreateNewPasswordState extends Equatable {
  const CreateNewPasswordState();

  @override
  List<Object> get props => <Object>[];
}

final class CreateNewPasswordInitial extends CreateNewPasswordState {}

final class CreateNewPasswordLoading extends CreateNewPasswordState {}

final class CreateNewPasswordSuccess extends CreateNewPasswordState {}

final class CreateNewPasswordError extends CreateNewPasswordState {
  final String message;

  const CreateNewPasswordError({required this.message});

}
