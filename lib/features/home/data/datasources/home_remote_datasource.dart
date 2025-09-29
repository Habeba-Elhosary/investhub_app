import 'package:investhub_app/core/util/api_base_helper.dart';
import 'package:investhub_app/features/home/data/models/all_departments_response.dart';
import 'package:investhub_app/features/home/data/models/all_offers_response.dart';
import 'package:investhub_app/features/home/data/models/all_products_response.dart';
import 'package:investhub_app/features/home/domain/repositories/home_repository.dart';

const String allDepartmentsAPI = '/auth/categories';
const String allProductsAPI = '/auth/products';
const String allOffersAPI = '/auth/offers';
const String departmentProductsAPI = '/auth/categories/';
const String showProductAPI = '/auth/products/';
const String showOfferDetailsAPI = '/auth/offers/';

abstract class HomeRemoteDatasource {
  Future<AllDepartmentsResponse> getAllDepartments(PaginationParams params);
  Future<AllProductsResponse> getAllProducts(AllProductsParams params);
  Future<AllProductsResponse> getDepartmentProducts(
    DepartmentProductsParams params,
  );
  Future<Product> showProduct(int productId);
  Future<AllOffersResponse> getAllOffers(PaginationParams params);
  Future<Offer> showOffer(int offerId);
}

class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  final ApiBaseHelper apiBaseHelper;
  HomeRemoteDatasourceImpl({required this.apiBaseHelper});

  @override
  Future<AllDepartmentsResponse> getAllDepartments(
    PaginationParams params,
  ) async {
    try {
      final response = await apiBaseHelper.get(
        url: allDepartmentsAPI,
        queryParameters: params.toJson(),
      );
      return AllDepartmentsResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AllProductsResponse> getAllProducts(AllProductsParams params) async {
    try {
      final response = await apiBaseHelper.get(
        url: allProductsAPI,
        queryParameters: params.toJson(),
      );
      return AllProductsResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AllProductsResponse> getDepartmentProducts(
    DepartmentProductsParams params,
  ) async {
    try {
      final response = await apiBaseHelper.get(
        url: departmentProductsAPI + params.departmentId.toString(),
        queryParameters: params.toJson(),
      );
      return AllProductsResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Product> showProduct(int productId) async {
    try {
      final response = await apiBaseHelper.get(
        url: showProductAPI + productId.toString(),
      );
      return Product.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AllOffersResponse> getAllOffers(PaginationParams params) async {
    try {
      final response = await apiBaseHelper.get(
        url: allOffersAPI,
        queryParameters: params.toJson(),
      );
      return AllOffersResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Offer> showOffer(int offerId) async {
    try {
      final response = await apiBaseHelper.get(
        url: showOfferDetailsAPI + offerId.toString(),
      );
      return Offer.fromJson(response['data']);
    } catch (e) {
      rethrow;
    }
  }
}
