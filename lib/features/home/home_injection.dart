import 'package:investhub_app/features/home/data/datasources/edit_profile_remote_datasource.dart';
import 'package:investhub_app/features/home/data/datasources/opportunities_remote_datasource.dart';
import 'package:investhub_app/features/home/data/datasources/subscriptions_remote_datasource.dart';
import 'package:investhub_app/features/home/data/repositories/edit_profile_repository_impl.dart';
import 'package:investhub_app/features/home/data/repositories/opportunities_repository_impl.dart';
import 'package:investhub_app/features/home/data/repositories/subscriptions_repository_impl.dart';
import 'package:investhub_app/features/home/domain/repositories/edit_profile_repository.dart';
import 'package:investhub_app/features/home/domain/repositories/opportunities_repository.dart';
import 'package:investhub_app/features/home/domain/repositories/subscriptions_repository.dart';
import 'package:investhub_app/features/home/domain/usecases/edit_profile_usecase.dart';
import 'package:investhub_app/features/home/domain/usecases/get_opportunities_usecase.dart';
import 'package:investhub_app/features/home/domain/usecases/get_subscriptions_usecase.dart';
import 'package:investhub_app/features/home/domain/usecases/subscribe_usecase.dart';
import 'package:investhub_app/features/home/presentation/cubit/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:investhub_app/features/home/presentation/cubit/edit_profile/edit_profile_cubit.dart';
import 'package:investhub_app/features/home/presentation/cubit/opportunities/opportunities_cubit.dart';
import 'package:investhub_app/features/home/presentation/cubit/profile/profile_cubit.dart';
import 'package:investhub_app/features/home/presentation/cubit/subscribe/subscribe_cubit.dart';
import 'package:investhub_app/features/home/presentation/cubit/subscriptions/subscriptions_cubit.dart';
import 'package:investhub_app/injection_container.dart';

void initHomeInjection() async {
  // * Cubits
  sl.registerFactory(() => BottomNavigationCubit());
  sl.registerFactory(() => SubscriptionsCubit(getSubscriptionsUsecase: sl()));
  sl.registerFactory(() => SubscribeCubit(subscribeUsecase: sl()));
  sl.registerFactory(() => OpportunitiesCubit(getOpportunitiesUsecase: sl()));
  sl.registerFactory(() => ProfileCubit(localDataSource: sl()));
  sl.registerFactory(
    () => EditProfileCubit(editProfileUsecase: sl(), localDataSource: sl()),
  );

  // * Usecases
  sl.registerLazySingleton(() => GetSubscriptionsUsecase(repository: sl()));
  sl.registerLazySingleton(() => SubscribeUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetOpportunitiesUsecase(repository: sl()));
  sl.registerLazySingleton(() => EditProfileUsecase(repository: sl()));

  // * Repository
  sl.registerLazySingleton<SubscriptionsRepository>(
    () => SubscriptionsRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<OpportunitiesRepository>(
    () => OpportunitiesRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<EditProfileRepository>(
    () => EditProfileRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );

  // * Datasources
  sl.registerLazySingleton<SubscriptionsRemoteDataSource>(
    () => SubscriptionsRemoteDataSourceImpl(apiBaseHelper: sl()),
  );
  sl.registerLazySingleton<OpportunitiesRemoteDataSource>(
    () => OpportunitiesRemoteDataSourceImpl(apiBaseHelper: sl()),
  );
  sl.registerLazySingleton<EditProfileRemoteDataSource>(
    () => EditProfileRemoteDataSourceImpl(apiBaseHelper: sl()),
  );
}
