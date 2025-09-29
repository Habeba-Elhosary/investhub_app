import 'package:investhub_app/core/entities/status_response.dart';
import 'package:investhub_app/core/error/exceptions.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:investhub_app/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:investhub_app/features/cart/domain/entities/cart_response.dart';
import 'package:investhub_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource cartRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  CartRepositoryImpl({
    required this.cartRemoteDataSource,
    required this.authLocalDataSource,
  });

  @override
  Future<Either<Failure, CartResponse>> showCart() async {
    try {
      final String token = await authLocalDataSource.getUserAccessToken();
      final response = await cartRemoteDataSource.showCart(token);
      return right(response);
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }

  @override
  Future<Either<Failure, StatusResponse>> addToCart(CartParams params) async {
    try {
      final String token = await authLocalDataSource.getUserAccessToken();
      final response = await cartRemoteDataSource.addToCart(params, token);
      return right(response);
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    } on ProductAlreadyExistInCartException catch (error) {
      return left(ProductAlreadyExistInCartFailure(message: error.message));
    }
  }

  @override
  Future<Either<Failure, StatusResponse>> updateCart(
    UpdateCartParams params,
  ) async {
    try {
      final String token = await authLocalDataSource.getUserAccessToken();
      final response = await cartRemoteDataSource.updateCart(params, token);
      return right(response);
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }

  @override
  Future<Either<Failure, StatusResponse>> removeFromCart(
    CartParams params,
  ) async {
    try {
      final String token = await authLocalDataSource.getUserAccessToken();
      final response = await cartRemoteDataSource.removeFromCart(params, token);
      return right(response);
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }
}
