import 'package:investhub_app/features/cart/domain/entities/cart_response.dart';
import 'package:investhub_app/features/orders/data/models/orders_details_response.dart';

class ProductInfo {
  final String name;
  final num quantity;
  // final double price;
  // final double? priceAfterDiscount;

  ProductInfo({
    required this.name,
    required this.quantity,
    // required this.price,
    // this.priceAfterDiscount,
  });

  factory ProductInfo.fromCart(CartData cartData) => ProductInfo(
    name: cartData.title,
    quantity: cartData.quantity,
    // price:  cartData.product.price.toDouble(),
    // priceAfterDiscount:  cartData.product.priceAfterDiscount?.toDouble(),
  );

  factory ProductInfo.fromOrder(OrderItem orderProduct) => ProductInfo(
    name: orderProduct.name,
    quantity: orderProduct.quantity,
    // price: orderProduct.price.toDouble(),
  );
}
