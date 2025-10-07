import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/features/general/domain/entities/banks_response.dart';
import 'package:investhub_app/features/general/domain/repositories/general_repository.dart';
import 'package:dartz/dartz.dart';

class GetBanksUsecase extends UseCase<BanksResponse, NoParams> {
  final GeneralRepository generalRepository;
  GetBanksUsecase({required this.generalRepository});

  @override
  Future<Either<Failure, BanksResponse>> call(NoParams params) =>
      generalRepository.getBanks();
}
