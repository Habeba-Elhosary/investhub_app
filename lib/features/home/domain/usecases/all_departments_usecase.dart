import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/features/home/data/models/all_departments_response.dart';
import 'package:investhub_app/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class AllDepartmentsUsecase
    extends UseCase<AllDepartmentsResponse, PaginationParams> {
  final HomeRepository homeRepository;

  AllDepartmentsUsecase({required this.homeRepository});
  @override
  Future<Either<Failure, AllDepartmentsResponse>> call(
    PaginationParams params,
  ) => homeRepository.getAllDepartments(params);
}
