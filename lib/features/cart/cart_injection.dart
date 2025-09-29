import 'package:investhub_app/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:investhub_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:investhub_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:investhub_app/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:investhub_app/features/cart/domain/usecases/remove_cart_usecase.dart';
import 'package:investhub_app/features/cart/domain/usecases/show_cart_usecase.dart';
import 'package:investhub_app/features/cart/domain/usecases/update_cart_usecase.dart';
import 'package:investhub_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:investhub_app/injection_container.dart';

void initCartInjection() async {
  // cubits
  sl.registerLazySingleton<CartCubit>(
    () => CartCubit(
      showCartUsecase: sl(),
      addToCartUsecase: sl(),
      updateCartUsecase: sl(),
      removeCartUsecase: sl(),
    ),
  );
  // usecase
  sl.registerLazySingleton(() => ShowCartUsecase(cartRepository: sl()));
  sl.registerLazySingleton(() => AddToCartUsecase(cartRepository: sl()));
  sl.registerLazySingleton(() => UpdateCartUsecase(cartRepository: sl()));
  sl.registerLazySingleton(() => RemoveCartUsecase(cartRepository: sl()));

  // repository
  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(
      cartRemoteDataSource: sl(),
      authLocalDataSource: sl(),
    ),
  );

  // datasources
  sl.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceImpl(apiBaseHelper: sl()),
  );
}
