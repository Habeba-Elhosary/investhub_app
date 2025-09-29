import 'package:investhub_app/core/enums/product_enum.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/features/home/data/models/all_departments_response.dart';
import 'package:investhub_app/features/home/data/models/all_offers_response.dart';
import 'package:investhub_app/features/home/data/models/all_products_response.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<Failure, AllDepartmentsResponse>> getAllDepartments(
    PaginationParams params,
  );
  Future<Either<Failure, AllProductsResponse>> getAllProducts(
    AllProductsParams params,
  );
  Future<Either<Failure, AllProductsResponse>> getDepartmentProducts(
    DepartmentProductsParams params,
  );
  Future<Either<Failure, Product>> showProduct(int productId);
  Future<Either<Failure, AllOffersResponse>> getAllOffers(
    PaginationParams params,
  );
  Future<Either<Failure, Offer>> showOffer(int offerId);
}

class PaginationParams {
  final int page;
  final String? searchText;
  PaginationParams({required this.page, this.searchText});

  Map<String, dynamic> toJson() {
    return {'page': page, if (searchText != null) 'search': searchText};
  }
}

class AllProductsParams extends PaginationParams {
  final ProductType? productType;
  AllProductsParams({this.productType, required super.page, super.searchText});

  @override
  Map<String, dynamic> toJson() {
    return {
      'page': page,
      if (searchText != null) 'search': searchText,
      if (productType != null) 'type': getProductTypeString(productType!),
    };
  }
}

class DepartmentProductsParams extends PaginationParams {
  final int departmentId;
  DepartmentProductsParams({
    required this.departmentId,
    required super.page,
    super.searchText,
  });

  @override
  Map<String, dynamic> toJson() {
    return {'page': page, if (searchText != null) 'search': searchText};
  }
}
