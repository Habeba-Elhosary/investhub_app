part of 'google_login_cubit.dart';

sealed class GoogleLoginState extends Equatable {
  const GoogleLoginState();

  @override
  List<Object> get props => <Object>[];
}

final class GoogleLoginInitial extends GoogleLoginState {}

final class GoogleLoginLoading extends GoogleLoginState {}

final class GoogleLoginError extends GoogleLoginState {
  final String message;

  const GoogleLoginError({required this.message});
}

final class GoogleLoginSuccess extends GoogleLoginState {}