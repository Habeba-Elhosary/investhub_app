import 'package:investhub_app/core/entities/status_response.dart';
import 'package:investhub_app/core/error/exceptions.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:investhub_app/features/orders/data/datasources/orders_remote_datasource.dart';
import 'package:investhub_app/features/orders/data/models/orders_details_response.dart';
import 'package:investhub_app/features/orders/data/models/orders_response.dart';
import 'package:investhub_app/features/orders/domain/repositories/order_repository.dart';
import 'package:dartz/dartz.dart';

class OrderRepositoryImpl implements OrderRepository {
  AuthLocalDataSource authLocalDataSource;
  OrderRemoteDataSource orderRemoteDataSource;

  OrderRepositoryImpl({
    required this.authLocalDataSource,
    required this.orderRemoteDataSource,
  });

  @override
  Future<Either<Failure, StatusResponse>> createOrder() async {
    try {
      final String token = await authLocalDataSource.getUserAccessToken();
      final response = await orderRemoteDataSource.createOrder(token: token);
      return right(response);
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }

  @override
  Future<Either<Failure, OrdersResponse>> showOrders({
    required ShowOrdersParams params,
  }) async {
    try {
      final String token = await authLocalDataSource.getUserAccessToken();
      final response = await orderRemoteDataSource.showOrders(
        token: token,
        params: params,
      );

      return right(response);
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }

  @override
  Future<Either<Failure, OrderDetailsResponse>> showOrderDetails({
    required int orderId,
  }) async {
    try {
      final String token = await authLocalDataSource.getUserAccessToken();
      final response = await orderRemoteDataSource.showOrderDetails(
        token: token,
        orderId: orderId,
      );
      return right(response);
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }
}
