import 'package:investhub_app/core/entities/status_response.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class GeneralRepository {
  Future<Either<Failure, StatusResponse>> sendComplaint(String content);
  Future<Either<Failure, String>> getStaticData(String type);
}
