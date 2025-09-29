import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/features/orders/data/models/orders_details_response.dart';
import 'package:investhub_app/features/orders/domain/repositories/order_repository.dart';
import 'package:dartz/dartz.dart';

class ShowOrderDetailsUsecase extends UseCase<OrderDetailsResponse, int> {
  final OrderRepository orderRepository;
  ShowOrderDetailsUsecase({required this.orderRepository});

  @override
  Future<Either<Failure, OrderDetailsResponse>> call(int params) =>
      orderRepository.showOrderDetails(orderId: params);
}
