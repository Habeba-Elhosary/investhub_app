import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/features/general/domain/repositories/general_repository.dart';
import 'package:dartz/dartz.dart';

class GetStaticDataUsecase extends UseCase<String, String> {
  final GeneralRepository generalRepository;

  GetStaticDataUsecase({required this.generalRepository});
  @override
  Future<Either<Failure, String>> call(String params) =>
      generalRepository.getStaticData(params);
}
