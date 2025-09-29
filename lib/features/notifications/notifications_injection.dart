import 'package:investhub_app/features/notifications/data/datasources/notification_remote_datasource.dart';
import 'package:investhub_app/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:investhub_app/features/notifications/domain/repositories/notification_repository.dart';
import 'package:investhub_app/features/notifications/domain/usecases/get_all_notification_usecase.dart';
import 'package:investhub_app/features/notifications/domain/usecases/get_unread_notification_usecase.dart';
import 'package:investhub_app/features/notifications/domain/usecases/mark_all_notification_as_read_usecase.dart';
import 'package:investhub_app/features/notifications/presentation/cubits/all_notification/all_notification_cubit.dart';
import 'package:investhub_app/features/notifications/presentation/cubits/mark_all_notification_read/mark_all_as_read_cubit.dart';
import 'package:investhub_app/features/notifications/presentation/cubits/unread_notification_count/unread_count_cubit.dart';
import 'package:investhub_app/injection_container.dart';

void initNotificationsInjection() async {
  //* Cubits
  sl.registerLazySingleton<AllNotificationsCubit>(
    () => AllNotificationsCubit(getAllNotificationsUseCase: sl()),
  );
  sl.registerLazySingleton(
    () => UnreadCountCubit(getUnreadNotificationUsecase: sl()),
  );
  sl.registerLazySingleton(
    () => MarkAllAsReadCubit(markAllNotificationsAsRead: sl()),
  );

  //* UseCasess
  sl.registerLazySingleton<GetAllNotificationsUseCase>(
    () => GetAllNotificationsUseCase(notificationsRepository: sl()),
  );
  sl.registerLazySingleton<GetUnreadNotificaCountUsecase>(
    () => GetUnreadNotificaCountUsecase(notificationsRepository: sl()),
  );
  sl.registerLazySingleton<MarkAllNotificationAsReadUsecase>(
    () => MarkAllNotificationAsReadUsecase(notificationsRepository: sl()),
  );

  //* Repositories
  sl.registerLazySingleton<NotificationsRepository>(
    () => NotificationsRepositoryImpl(
      authLocalDataSource: sl(),
      notificationsRemoteDataSource: sl(),
    ),
  );

  //* Data Sources
  sl.registerLazySingleton<NotificationsRemoteDatasource>(
    () => NotificationsRemoteDatasourceImpl(apiBaseHelper: sl()),
  );
}
