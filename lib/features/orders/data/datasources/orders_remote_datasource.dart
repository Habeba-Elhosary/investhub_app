import 'package:investhub_app/core/entities/status_response.dart';
import 'package:investhub_app/core/util/api_base_helper.dart';
import 'package:investhub_app/features/orders/data/models/orders_details_response.dart';
import 'package:investhub_app/features/orders/data/models/orders_response.dart';
import 'package:investhub_app/features/orders/domain/repositories/order_repository.dart';

const String createOrderAPI = '/auth/orders/create';
const String showOrdersAPI = '/auth/orders/list';
const String showOrderDetailsAPI = '/auth/orders/details/';

abstract class OrderRemoteDataSource {
  Future<StatusResponse> createOrder({required String token});
  Future<OrdersResponse> showOrders({
    required String token,
    required ShowOrdersParams params,
  });
  Future<OrderDetailsResponse> showOrderDetails({
    required String token,
    required int orderId,
  });
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  ApiBaseHelper apiBaseHelper;

  OrderRemoteDataSourceImpl({required this.apiBaseHelper});
  @override
  Future<StatusResponse> createOrder({required String token}) async {
    try {
      final response = await apiBaseHelper.post(
        url: createOrderAPI,
        token: token,
        body: {},
      );
      return StatusResponse.fromJson(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<OrdersResponse> showOrders({
    required String token,
    required ShowOrdersParams params,
  }) async {
    try {
      final response = await apiBaseHelper.get(
        url: showOrdersAPI,
        token: token,
        queryParameters: params.toJson(),
      );
      return OrdersResponse.fromJson(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<OrderDetailsResponse> showOrderDetails({
    required String token,
    required int orderId,
  }) async {
    try {
      final response = await apiBaseHelper.get(
        url: showOrderDetailsAPI + orderId.toString(),
        token: token,
      );
      return OrderDetailsResponse.fromJson(response);
    } catch (error) {
      rethrow;
    }
  }
}
