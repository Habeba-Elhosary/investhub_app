import 'package:investhub_app/features/general/data/datasources/general_remote_datasource.dart';
import 'package:investhub_app/features/general/data/repositories/general_repository_impl.dart';
import 'package:investhub_app/features/general/domain/repositories/general_repository.dart';
import 'package:investhub_app/features/general/domain/usecases/get_banks_usecase.dart';
import 'package:investhub_app/features/general/domain/usecases/get_registration_questions_usecase.dart';
import 'package:investhub_app/features/general/presentation/cubits/get_banks/get_banks_cubit.dart';
import 'package:investhub_app/features/general/presentation/cubits/registration_questions/registration_questions_cubit.dart';
import 'package:investhub_app/injection_container.dart';

void initGeneralInjection() async {
  // * Cubits
  sl.registerLazySingleton(() => GetBanksCubit(banksUseCase: sl()));
  sl.registerLazySingleton(
    () => RegistrationQuestionsCubit(questionsUsecase: sl()),
  );

  // * Usecases
  sl.registerLazySingleton(
    () => GetRegistrationQuestionsUsecase(generalRepository: sl()),
  );
  sl.registerLazySingleton(() => GetBanksUsecase(generalRepository: sl()));

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
