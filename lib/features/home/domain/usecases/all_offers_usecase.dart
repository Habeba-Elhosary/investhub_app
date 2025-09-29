import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/features/home/data/models/all_offers_response.dart';
import 'package:investhub_app/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class AllOffersUsecase extends UseCase<AllOffersResponse, PaginationParams> {
  final HomeRepository homeRepository;

  AllOffersUsecase({required this.homeRepository});
  @override
  Future<Either<Failure, AllOffersResponse>> call(PaginationParams params) =>
      homeRepository.getAllOffers(params);
}
