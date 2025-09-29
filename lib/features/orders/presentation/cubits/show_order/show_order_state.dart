part of 'show_order_cubit.dart';

class ShowOrderState extends Equatable {
  final RequestStatus allRequestStatus;
  final RequestStatus paginationRequestStatus;
  final List<OrderData> orders;
  final String generalErrorMessage;
  final String paginationErrorMessage;
  final int currentPage;
  final int lastPage;
  final OrderType orderType;
  final Color indicatorColor;

  const ShowOrderState({
    this.allRequestStatus = RequestStatus.initial,
    this.paginationRequestStatus = RequestStatus.initial,
    this.orderType = OrderType.pending,
    this.orders = const <OrderData>[],
    this.generalErrorMessage = '',
    this.paginationErrorMessage = '',
    this.currentPage = 1,
    this.lastPage = 1,
    this.indicatorColor = AppColors.primary,
  });

  @override
  List<Object?> get props => <Object?>[
    allRequestStatus,
    paginationRequestStatus,
    List<OrderData>.from(orders),
    generalErrorMessage,
    paginationErrorMessage,
    currentPage,
    lastPage,
    orderType,
    indicatorColor,
  ];

  ShowOrderState copyWith({
    RequestStatus? allRequestStatus,
    RequestStatus? paginationRequestStatus,
    List<OrderData>? orders,
    String? generalErrorMessage,
    String? paginationErrorMessage,
    int? currentPage,
    int? lastPage,
    OrderType? orderType,
    Color? indicatorColor,
  }) {
    return ShowOrderState(
      allRequestStatus: allRequestStatus ?? this.allRequestStatus,
      paginationRequestStatus:
          paginationRequestStatus ?? this.paginationRequestStatus,
      orders: orders ?? this.orders,
      paginationErrorMessage:
          paginationErrorMessage ?? this.paginationErrorMessage,
      generalErrorMessage: generalErrorMessage ?? this.generalErrorMessage,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      orderType: orderType ?? this.orderType,
      indicatorColor: indicatorColor ?? this.indicatorColor,
    );
  }
}
