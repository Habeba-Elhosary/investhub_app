import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/features/notifications/domain/repositories/notification_repository.dart';
import 'package:dartz/dartz.dart';

class MarkAllNotificationAsReadUsecase extends UseCase<Unit, NoParams> {
  final NotificationsRepository notificationsRepository;

  MarkAllNotificationAsReadUsecase({required this.notificationsRepository});

  @override
  Future<Either<Failure, Unit>> call(NoParams params) {
    return notificationsRepository.markAllNotificationsAsRead();
  }
}
