import 'package:investhub_app/features/orders/data/models/orders_details_response.dart';
import 'package:investhub_app/features/orders/domain/usecases/show_order_details_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'show_order_details_state.dart';

class ShowOrderDetailsCubit extends Cubit<ShowOrderDetailsState> {
  final ShowOrderDetailsUsecase showOrderDetailsUsecase;
  ShowOrderDetailsCubit({required this.showOrderDetailsUsecase})
    : super(ShowOrderDetailsInitial());

  Future<void> showOrderDetails(int orderId) async {
    emit(ShowOrderDetailsLoading());
    final response = await showOrderDetailsUsecase(orderId);

    response.fold(
      (failure) => emit(ShowOrderDetailsError(message: failure.message)),
      (orderDetails) =>
          emit(ShowOrderDetailsSuccess(orderDetailsData: orderDetails.data)),
    );
  }
}
