import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/enums/order_type_enum.dart';
import 'package:investhub_app/core/util/request_status.dart';
import 'package:investhub_app/features/orders/data/models/orders_response.dart';
import 'package:investhub_app/features/orders/domain/repositories/order_repository.dart';
import 'package:investhub_app/features/orders/domain/usecases/show_orders_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'show_order_state.dart';

class ShowOrderCubit extends Cubit<ShowOrderState> {
  final ShowOrdersUsecase showOrdersUsecase;

  ShowOrderCubit({required this.showOrdersUsecase})
    : super(
        ShowOrderState(
          orderType: OrderType.pending,
          indicatorColor: OrderType.pending.color,
        ),
      );

  late TabController tabController;
  final List<OrderType> orderTypes = OrderType.values;
  final ScrollController scrollController = ScrollController();

  void initScoll() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        loadMoreOrders();
      }
    });
  }

  void initialize(TickerProvider vsync) {
    tabController = TabController(length: orderTypes.length, vsync: vsync)
      ..addListener(handleTabChange);

    emit(
      state.copyWith(
        orderType: OrderType.pending,
        indicatorColor: OrderType.pending.color,
      ),
    );

    getOrdersForFirstTime();
  }

  void handleTabChange() {
    if (!tabController.indexIsChanging) {
      final selectedType = orderTypes[tabController.index];
      emit(
        state.copyWith(
          allRequestStatus: RequestStatus.loading,
          orders: [],
          currentPage: 1,
          lastPage: 1,
          orderType: selectedType,
          indicatorColor: selectedType.color,
        ),
      );
      getOrdersForFirstTime();
    }
  }

  void refreshOrders() {
    final currentType = orderTypes[tabController.index];
    emit(
      state.copyWith(orderType: currentType, indicatorColor: currentType.color),
    );
    getOrdersForFirstTime();
  }

  Future<void> getOrdersForFirstTime() async {
    emit(
      state.copyWith(
        allRequestStatus: RequestStatus.loading,
        orders: [],
        currentPage: 1,
        lastPage: 1,
      ),
    );

    final result = await showOrdersUsecase(
      ShowOrdersParams(type: state.orderType, page: 1),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          allRequestStatus: RequestStatus.error,
          generalErrorMessage: failure.message,
        ),
      ),
      (response) => emit(
        state.copyWith(
          allRequestStatus: RequestStatus.success,
          orders: response.data,
          currentPage: response.meta.currentPage,
          lastPage: response.meta.lastPage,
        ),
      ),
    );
  }

  Future<void> loadMoreOrders() async {
    if (state.currentPage >= state.lastPage) return;

    emit(
      state.copyWith(
        currentPage: state.currentPage + 1,
        paginationRequestStatus: RequestStatus.loading,
      ),
    );

    final result = await showOrdersUsecase(
      ShowOrdersParams(page: state.currentPage, type: state.orderType),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          currentPage: state.currentPage - 1,
          paginationRequestStatus: RequestStatus.error,
          paginationErrorMessage: failure.message,
        ),
      ),
      (response) => emit(
        state.copyWith(
          paginationRequestStatus: RequestStatus.success,
          orders: List.from(state.orders + response.data),
          lastPage: response.meta.lastPage,
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    tabController.dispose();
    return super.close();
  }
}
