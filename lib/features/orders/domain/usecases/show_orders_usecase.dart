import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/features/orders/data/models/orders_response.dart';
import 'package:investhub_app/features/orders/domain/repositories/order_repository.dart';
import 'package:dartz/dartz.dart';

class ShowOrdersUsecase extends UseCase<OrdersResponse, ShowOrdersParams> {
  final OrderRepository orderRepository;
  ShowOrdersUsecase({required this.orderRepository});

  @override
  Future<Either<Failure, OrdersResponse>> call(ShowOrdersParams params) =>
      orderRepository.showOrders(params: params);
}
