import 'package:investhub_app/core/entities/status_response.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/features/general/domain/repositories/general_repository.dart';
import 'package:dartz/dartz.dart';

class SendComplaintUsecase extends UseCase<StatusResponse, String> {
  final GeneralRepository generalRepository;

  SendComplaintUsecase({required this.generalRepository});
  @override
  Future<Either<Failure, StatusResponse>> call(String params) =>
      generalRepository.sendComplaint(params);
}
