part of 'auto_login_cubit.dart';

sealed class AutoLoginState extends Equatable {
  const AutoLoginState();

  @override
  List<Object> get props => [];
}

class AutoLoginInitial extends AutoLoginState {}

class AutoLoginError extends AutoLoginState {
  final String message;
  const AutoLoginError({required this.message});
}

class AutoLoginHasUser extends AutoLoginState {

  const AutoLoginHasUser();
}

class AutoLoginNoUser extends AutoLoginState {}

class AutoLoginLoading extends AutoLoginState {}

class AutoLoginSeenIntro extends AutoLoginState {}