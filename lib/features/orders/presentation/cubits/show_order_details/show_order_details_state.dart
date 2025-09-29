part of 'show_order_details_cubit.dart';

sealed class ShowOrderDetailsState extends Equatable {
  const ShowOrderDetailsState();

  @override
  List<Object> get props => [];
}

final class ShowOrderDetailsInitial extends ShowOrderDetailsState {}

final class ShowOrderDetailsLoading extends ShowOrderDetailsState {}

final class ShowOrderDetailsError extends ShowOrderDetailsState {
  final String message;
  const ShowOrderDetailsError({required this.message});
}

final class ShowOrderDetailsSuccess extends ShowOrderDetailsState {
  final OrderDetailsData orderDetailsData;
  const ShowOrderDetailsSuccess({required this.orderDetailsData});
}
