import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/features/notifications/domain/repositories/notification_repository.dart';
import 'package:dartz/dartz.dart';

class GetUnreadNotificaCountUsecase extends UseCase<int, NoParams> {
  final NotificationsRepository notificationsRepository;

  GetUnreadNotificaCountUsecase({required this.notificationsRepository});

  @override
  Future<Either<Failure, int>> call(NoParams params) =>
      notificationsRepository.getUnreadNotificationsCount();
}
