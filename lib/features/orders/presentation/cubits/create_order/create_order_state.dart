part of 'create_order_cubit.dart';

sealed class CreateOrderState extends Equatable {
  const CreateOrderState();

  @override
  List<Object> get props => [];
}

class CreateOrderInitial extends CreateOrderState {}

class CreateOrderLoading extends CreateOrderState {}

class CreateOrderSuccess extends CreateOrderState {}

class CreateOrderError extends CreateOrderState {
  final String message;
  const CreateOrderError({required this.message});
}
