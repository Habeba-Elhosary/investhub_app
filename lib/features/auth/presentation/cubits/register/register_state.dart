part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterFailure extends RegisterState {
  final String message;

  const RegisterFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class RegisterSuccess extends RegisterState {}

class RegisterStepChanged extends RegisterState {
  final int step;

  const RegisterStepChanged(this.step);

  @override
  List<Object?> get props => [step];
}

