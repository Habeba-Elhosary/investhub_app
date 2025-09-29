import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/core/widgets/toast.dart';
import 'package:investhub_app/features/orders/domain/usecases/create_order_usecase.dart';
import 'package:investhub_app/features/orders/presentation/pages/order_success_screen.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_order_state.dart';

class CreateOrderCubit extends Cubit<CreateOrderState> {
  final CreateOrderUsecase createOrderUsecase;
  CreateOrderCubit({required this.createOrderUsecase})
    : super(CreateOrderInitial());

  void createOrderEvent() async {
    emit(CreateOrderLoading());
    final result = await createOrderUsecase.call(NoParams());
    result.fold(
      (failure) {
        showErrorToast(failure.message);
        emit(CreateOrderError(message: failure.message));
      },
      (response) {
        emit(CreateOrderSuccess());
        showSucessToast(response.message);
        appNavigator.pushReplacement(screen: const OrderSuccessScreen());
      },
    );
  }
}
