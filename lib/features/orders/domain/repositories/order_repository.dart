import 'package:investhub_app/core/entities/status_response.dart';
import 'package:investhub_app/core/enums/order_type_enum.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/features/home/domain/repositories/home_repository.dart';
import 'package:investhub_app/features/orders/data/models/orders_details_response.dart';
import 'package:investhub_app/features/orders/data/models/orders_response.dart';
import 'package:dartz/dartz.dart';

abstract class OrderRepository {
  Future<Either<Failure, StatusResponse>> createOrder();
  Future<Either<Failure, OrdersResponse>> showOrders({
    required ShowOrdersParams params,
  });
  Future<Either<Failure, OrderDetailsResponse>> showOrderDetails({
    required int orderId,
  });
}

class ShowOrdersParams extends PaginationParams {
  final OrderType type;
  ShowOrdersParams({required this.type, required super.page});

  @override
  Map<String, dynamic> toJson() => {
    'type': getOrderTypeString(type),
    'page': page,
  };
}
