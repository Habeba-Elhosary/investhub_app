part of 'cart_cubit.dart';

extension RequestStatusX on RequestStatus {
  bool get isLoading => this == RequestStatus.loading;
  bool get isSuccess => this == RequestStatus.success;
  bool get isError => this == RequestStatus.error;
}

class CartState extends Equatable {
  final List<CartData> items;
  final num totalItems;
  final RequestStatus requestStatus;
  final String errorMessage;

  const CartState({
    this.items = const [],
    this.totalItems = 0,
    this.requestStatus = RequestStatus.initial,
    this.errorMessage = '',
  });

  CartState copyWith({
    List<CartData>? items,
    num? totalItems,
    RequestStatus? requestStatus,
    String? errorMessage,
  }) {
    return CartState(
      items: items ?? this.items,
      totalItems: totalItems ?? this.totalItems,
      requestStatus: requestStatus ?? this.requestStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    List.from(items),
    totalItems,
    requestStatus,
    errorMessage,
  ];
}
