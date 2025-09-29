import 'package:investhub_app/core/entities/status_response.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/features/orders/domain/repositories/order_repository.dart';
import 'package:dartz/dartz.dart';

class CreateOrderUsecase extends UseCase<StatusResponse, NoParams> {
  final OrderRepository orderRepository;
  CreateOrderUsecase({required this.orderRepository});

  @override
  Future<Either<Failure, StatusResponse>> call(NoParams params) =>
      orderRepository.createOrder();
}
