import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/features/home/data/models/all_products_response.dart';
import 'package:investhub_app/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class ShowProductUsecase extends UseCase<Product, int> {
  final HomeRepository homeRepository;

  ShowProductUsecase({required this.homeRepository});
  @override
  Future<Either<Failure, Product>> call(int params) =>
      homeRepository.showProduct(params);
}
