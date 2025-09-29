import 'package:investhub_app/core/entities/status_response.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

class RemoveCartUsecase extends UseCase<StatusResponse, CartParams> {
  final CartRepository cartRepository;
  RemoveCartUsecase({required this.cartRepository});

  @override
  Future<Either<Failure, StatusResponse>> call(CartParams params) =>
      cartRepository.removeFromCart(params);
}
