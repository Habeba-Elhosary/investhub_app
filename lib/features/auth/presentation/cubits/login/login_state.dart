part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => <Object>[];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginError extends LoginState {
  final String message;

  const LoginError({required this.message});
}

final class LoginSuccess extends LoginState {}

final class LoginOtpRequired extends LoginState {
  final String otpToken;

  const LoginOtpRequired({required this.otpToken});

  @override
  List<Object> get props => [otpToken];
}
