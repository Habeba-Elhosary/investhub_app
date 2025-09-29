import 'package:investhub_app/features/home/data/datasources/home_remote_datasource.dart';
import 'package:investhub_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:investhub_app/features/home/domain/repositories/home_repository.dart';
import 'package:investhub_app/features/home/domain/usecases/all_departments_usecase.dart';
import 'package:investhub_app/features/home/domain/usecases/all_offers_usecase.dart';
import 'package:investhub_app/features/home/domain/usecases/all_products_usecase.dart';
import 'package:investhub_app/features/home/domain/usecases/get_department_products_usecase.dart';
import 'package:investhub_app/features/home/domain/usecases/show_offer_usecase.dart';
import 'package:investhub_app/features/home/domain/usecases/show_product_usecase.dart';
import 'package:investhub_app/features/home/presentation/cubits/all_departments/all_deparments_cubit.dart';
import 'package:investhub_app/features/home/presentation/cubits/all_offers/all_offers_cubit.dart';
import 'package:investhub_app/features/home/presentation/cubits/all_products/all_batteries_cubit.dart';
import 'package:investhub_app/features/home/presentation/cubits/all_products/all_tires_cubit.dart';
import 'package:investhub_app/features/home/presentation/cubits/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:investhub_app/features/home/presentation/cubits/department_products/department_products_cubit.dart';
import 'package:investhub_app/features/home/presentation/cubits/show_offer/show_offer_cubit.dart';
import 'package:investhub_app/features/home/presentation/cubits/show_product/show_product_cubit.dart';
import 'package:investhub_app/injection_container.dart';

void initHomeInjection() async {
  // * Cubits
  sl.registerFactory(() => BottomNavigationCubit());
  sl.registerFactory(() => AllDeparmentsCubit(allDepartments: sl()));
  sl.registerFactory(() => AllTiresCubit(allProducts: sl()));
  sl.registerFactory(() => AllBatteriesCubit(allProducts: sl()));
  sl.registerFactory(
    () => DepartmentProductsCubit(getDepartmentProducts: sl()),
  );
  sl.registerFactory(() => ShowProductCubit(showProductUsecase: sl()));
  sl.registerFactory(() => AllOffersCubit(allOffersUsecase: sl()));
  sl.registerFactory(() => ShowOfferCubit(showOfferUsecase: sl()));

  // * Usecases
  sl.registerLazySingleton(() => AllDepartmentsUsecase(homeRepository: sl()));
  sl.registerLazySingleton(() => AllProductsUsecase(homeRepository: sl()));
  sl.registerLazySingleton(
    () => GetDepartmentProductsUsecase(homeRepository: sl()),
  );
  sl.registerLazySingleton(() => ShowProductUsecase(homeRepository: sl()));
  sl.registerLazySingleton(() => AllOffersUsecase(homeRepository: sl()));
  sl.registerLazySingleton(() => ShowOfferUsecase(homeRepository: sl()));

  // * Repository
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      homeRemoteDatasource: sl(),
      authLocalDataSource: sl(),
    ),
  );

  // * Datasources
  sl.registerLazySingleton<HomeRemoteDatasource>(
    () => HomeRemoteDatasourceImpl(apiBaseHelper: sl()),
  );
}
