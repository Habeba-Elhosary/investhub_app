import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/features/home/data/models/all_offers_response.dart';
import 'package:investhub_app/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class ShowOfferUsecase extends UseCase<Offer, int> {
  final HomeRepository homeRepository;

  ShowOfferUsecase({required this.homeRepository});
  @override
  Future<Either<Failure, Offer>> call(int params) =>
      homeRepository.showOffer(params);
}
