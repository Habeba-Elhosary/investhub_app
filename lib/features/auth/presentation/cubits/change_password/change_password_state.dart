part of 'change_password_cubit.dart';

sealed class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object?> get props => [];
}

final class ChangePasswordInitial extends ChangePasswordState {}

final class ChangePasswordLoading extends ChangePasswordState {}

final class ChangePasswordSuccess extends ChangePasswordState {
  final String message;

  const ChangePasswordSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

final class ChangePasswordError extends ChangePasswordState {
  final String message;

  const ChangePasswordError({required this.message});

  @override
  List<Object?> get props => [message];
}
