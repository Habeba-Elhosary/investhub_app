import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/features/cart/domain/entities/cart_response.dart';
import 'package:investhub_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

class ShowCartUsecase extends UseCase<CartResponse, NoParams> {
  final CartRepository cartRepository;
  ShowCartUsecase({required this.cartRepository});

  @override
  Future<Either<Failure, CartResponse>> call(NoParams params) =>
      cartRepository.showCart();
}
