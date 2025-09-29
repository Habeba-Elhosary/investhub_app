import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/features/home/data/models/all_products_response.dart';
import 'package:investhub_app/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class GetDepartmentProductsUsecase
    extends UseCase<AllProductsResponse, DepartmentProductsParams> {
  final HomeRepository homeRepository;

  GetDepartmentProductsUsecase({required this.homeRepository});
  @override
  Future<Either<Failure, AllProductsResponse>> call(
    DepartmentProductsParams params,
  ) => homeRepository.getDepartmentProducts(params);
}
