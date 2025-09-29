import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/features/home/domain/repositories/home_repository.dart';
import 'package:investhub_app/features/notifications/domain/entities/notification_response.dart';
import 'package:investhub_app/features/notifications/domain/repositories/notification_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllNotificationsUseCase
    extends UseCase<AllNotificationsResponse, PaginationParams> {
  final NotificationsRepository notificationsRepository;

  GetAllNotificationsUseCase({required this.notificationsRepository});
  @override
  Future<Either<Failure, AllNotificationsResponse>> call(
    PaginationParams params,
  ) {
    return notificationsRepository.getAllNotifications(params: params);
  }
}
