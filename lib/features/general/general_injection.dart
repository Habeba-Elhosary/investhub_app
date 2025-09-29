import 'package:investhub_app/features/general/data/datasources/general_remote_datasource.dart';
import 'package:investhub_app/features/general/data/repositories/general_repository_impl.dart';
import 'package:investhub_app/features/general/domain/repositories/general_repository.dart';
import 'package:investhub_app/features/general/domain/usecases/get_static_data_usecase.dart';
import 'package:investhub_app/features/general/domain/usecases/send_complaint_usecase.dart';
import 'package:investhub_app/features/general/presentation/cubits/send_complaint/send_complaint_cubit.dart';
import 'package:investhub_app/features/general/presentation/cubits/static_data/static_data_cubit.dart';
import 'package:investhub_app/injection_container.dart';

void initGeneralInjection() async {
  // * Cubits
  sl.registerFactory(() => SendComplaintCubit(sendComplaintUsecase: sl()));
  sl.registerFactory(() => StaticDataCubit(getStaticDataUsecase: sl()));

  // * Usecases
  sl.registerLazySingleton(() => SendComplaintUsecase(generalRepository: sl()));
  sl.registerLazySingleton(() => GetStaticDataUsecase(generalRepository: sl()));

  // * Repositories
  sl.registerLazySingleton<GeneralRepository>(
    () => GeneralRepositoryImpl(
      generalRemoteDataSource: sl(),
      authLocalDataSource: sl(),
    ),
  );

  // * Datasources
  sl.registerLazySingleton<GeneralRemoteDataSource>(
    () => GeneralRemoteDataSourceImpl(apiBaseHelper: sl()),
  );
}
