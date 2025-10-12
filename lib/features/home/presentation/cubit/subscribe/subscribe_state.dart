part of 'subscribe_cubit.dart';

abstract class SubscribeState extends Equatable {
  const SubscribeState();

  @override
  List<Object?> get props => [];
}

class SubscribeInitial extends SubscribeState {}

class SubscribeLoading extends SubscribeState {}

class SubscribeSuccess extends SubscribeState {
  final String message;

  const SubscribeSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class SubscribeError extends SubscribeState {
  final String message;

  const SubscribeError({required this.message});

  @override
  List<Object?> get props => [message];
}
