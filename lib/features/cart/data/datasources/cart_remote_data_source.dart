import 'package:investhub_app/core/entities/status_response.dart';
import 'package:investhub_app/core/enums/item_enum.dart';
import 'package:investhub_app/core/util/api_base_helper.dart';
import 'package:investhub_app/features/cart/domain/entities/cart_response.dart';
import 'package:investhub_app/features/cart/domain/repositories/cart_repository.dart';

const String showCartAPI = '/auth/cart/show';
const String addToCartAPI = '/auth/cart/add';
const String updateCartAPI = '/auth/cart/update';
String removeFromCartAPI(int productId) => '/auth/cart/remove/$productId';

abstract class CartRemoteDataSource {
  Future<StatusResponse> addToCart(CartParams params, String token);
  Future<StatusResponse> updateCart(UpdateCartParams params, String token);
  Future<CartResponse> showCart(String token);
  Future<StatusResponse> removeFromCart(CartParams params, String token);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final ApiBaseHelper apiBaseHelper;

  CartRemoteDataSourceImpl({required this.apiBaseHelper});

  @override
  Future<CartResponse> showCart(String token) async {
    try {
      final response = await apiBaseHelper.get(url: showCartAPI, token: token);
      return CartResponse.fromJson(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<StatusResponse> addToCart(CartParams params, String token) async {
    try {
      final response = await apiBaseHelper.post(
        body: params.toJson(),
        url: addToCartAPI,
        token: token,
      );
      return StatusResponse.fromJson(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<StatusResponse> updateCart(
    UpdateCartParams params,
    String token,
  ) async {
    try {
      final response = await apiBaseHelper.post(
        body: params.toJson(),
        url: updateCartAPI,
        token: token,
      );
      return StatusResponse.fromJson(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<StatusResponse> removeFromCart(CartParams params, String token) async {
    try {
      final response = await apiBaseHelper.delete(
        url: removeFromCartAPI(params.itemId),
        queryParameters: {'type': getItemTypeString((params.itemType))},
        token: token,
      );
      return StatusResponse.fromJson(response);
    } catch (error) {
      rethrow;
    }
  }
}
