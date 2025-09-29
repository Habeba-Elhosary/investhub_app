part of 'register_cubit.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => <Object>[];
}

final class RegisterInitial extends RegisterState {}
   
   
final class RegisterLoading extends RegisterState {}

final class RegisterError extends RegisterState {
  final String message;

  const RegisterError({required this.message});

  @override
  List<Object> get props => <Object>[message];
}

final class RegisterSuccess extends RegisterState {}
