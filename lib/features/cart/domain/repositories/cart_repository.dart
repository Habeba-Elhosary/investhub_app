import 'package:investhub_app/core/entities/status_response.dart';
import 'package:investhub_app/core/enums/item_enum.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/features/cart/domain/entities/cart_response.dart';
import 'package:dartz/dartz.dart';

abstract class CartRepository {
  Future<Either<Failure, StatusResponse>> addToCart(CartParams params);
  Future<Either<Failure, StatusResponse>> updateCart(UpdateCartParams params);
  Future<Either<Failure, CartResponse>> showCart();
  Future<Either<Failure, StatusResponse>> removeFromCart(CartParams params);
}

class CartParams {
  final int itemId;
  final ItemType itemType;
  const CartParams({required this.itemId, required this.itemType});
  Map<String, dynamic> toJson() {
    return {'item_id': itemId, 'type': getItemTypeString(itemType)};
  }
}

class UpdateCartParams {
  final int itemId;
  final int quantity;
  final ItemType itemType;

  UpdateCartParams({
    required this.itemId,
    required this.quantity,
    required this.itemType,
  });

  Map<String, dynamic> toJson() => {
    'item_id': itemId,
    'quantity': quantity,
    'type': getItemTypeString(itemType),
  };
}
