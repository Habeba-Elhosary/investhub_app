import 'package:investhub_app/core/entities/status_response.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateCartUsecase extends UseCase<StatusResponse, UpdateCartParams> {
  final CartRepository cartRepository;
  UpdateCartUsecase({required this.cartRepository});

  @override
  Future<Either<Failure, StatusResponse>> call(UpdateCartParams params) =>
      cartRepository.updateCart(params);
}
