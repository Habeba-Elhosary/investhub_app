part of 'subscriptions_cubit.dart';

abstract class SubscriptionsState extends Equatable {
  const SubscriptionsState();

  @override
  List<Object?> get props => [];
}

class SubscriptionsInitial extends SubscriptionsState {}

class SubscriptionsLoading extends SubscriptionsState {}

class SubscriptionsSuccess extends SubscriptionsState {
  final List<SubscriptionPackage> subscriptions;

  const SubscriptionsSuccess({required this.subscriptions});

  @override
  List<Object?> get props => [subscriptions];
}

class SubscriptionsError extends SubscriptionsState {
  final String message;

  const SubscriptionsError({required this.message});

  @override
  List<Object?> get props => [message];
}
