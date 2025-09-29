import 'package:investhub_app/core/error/exceptions.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:investhub_app/features/home/data/datasources/home_remote_datasource.dart';
import 'package:investhub_app/features/home/data/models/all_departments_response.dart';
import 'package:investhub_app/features/home/data/models/all_offers_response.dart';
import 'package:investhub_app/features/home/data/models/all_products_response.dart';
import 'package:investhub_app/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasource homeRemoteDatasource;
  final AuthLocalDataSource authLocalDataSource;

  HomeRepositoryImpl({
    required this.homeRemoteDatasource,
    required this.authLocalDataSource,
  });

  @override
  Future<Either<Failure, AllDepartmentsResponse>> getAllDepartments(
    PaginationParams params,
  ) async {
    try {
      return right(await homeRemoteDatasource.getAllDepartments(params));
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }

  @override
  Future<Either<Failure, AllProductsResponse>> getAllProducts(
    AllProductsParams params,
  ) async {
    try {
      return right(await homeRemoteDatasource.getAllProducts(params));
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }

  @override
  Future<Either<Failure, AllProductsResponse>> getDepartmentProducts(
    DepartmentProductsParams param,
  ) async {
    try {
      return right(await homeRemoteDatasource.getDepartmentProducts(param));
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }

  @override
  Future<Either<Failure, Product>> showProduct(int productId) async {
    try {
      return right(await homeRemoteDatasource.showProduct(productId));
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }

  @override
  Future<Either<Failure, AllOffersResponse>> getAllOffers(
    PaginationParams params,
  ) async {
    try {
      return right(await homeRemoteDatasource.getAllOffers(params));
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }

  @override
  Future<Either<Failure, Offer>> showOffer(int offerId) async {
    try {
      return right(await homeRemoteDatasource.showOffer(offerId));
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }
}
