part of 'logout_cubit.dart';

sealed class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object> get props => <Object>[];
}

final class LogoutInitial extends LogoutState {}

final class LogoutLoading extends LogoutState {}

final class LogoutError extends LogoutState {
  final String message;

  const LogoutError({required this.message});
}

final class LogoutSuccess extends LogoutState {}
