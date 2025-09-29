import 'package:investhub_app/features/orders/data/datasources/orders_remote_datasource.dart';
import 'package:investhub_app/features/orders/data/repositories/order_repository_impl.dart';
import 'package:investhub_app/features/orders/domain/repositories/order_repository.dart';
import 'package:investhub_app/features/orders/domain/usecases/create_order_usecase.dart';
import 'package:investhub_app/features/orders/domain/usecases/show_order_details_usecase.dart';
import 'package:investhub_app/features/orders/domain/usecases/show_orders_usecase.dart';
import 'package:investhub_app/features/orders/presentation/cubits/create_order/create_order_cubit.dart';
import 'package:investhub_app/features/orders/presentation/cubits/show_order/show_order_cubit.dart';
import 'package:investhub_app/features/orders/presentation/cubits/show_order_details/show_order_details_cubit.dart';
import 'package:investhub_app/injection_container.dart';

void initOrderInjection() async {
  // cubits
  sl.registerFactory<ShowOrderCubit>(
    () => ShowOrderCubit(showOrdersUsecase: sl()),
  );
  sl.registerFactory<CreateOrderCubit>(
    () => CreateOrderCubit(createOrderUsecase: sl()),
  );
  sl.registerFactory<ShowOrderDetailsCubit>(
    () => ShowOrderDetailsCubit(showOrderDetailsUsecase: sl()),
  );

  // usecase
  sl.registerLazySingleton<ShowOrdersUsecase>(
    () => ShowOrdersUsecase(orderRepository: sl()),
  );
  sl.registerLazySingleton<CreateOrderUsecase>(
    () => CreateOrderUsecase(orderRepository: sl()),
  );
  sl.registerLazySingleton<ShowOrderDetailsUsecase>(
    () => ShowOrderDetailsUsecase(orderRepository: sl()),
  );

  // repository
  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(
      authLocalDataSource: sl(),
      orderRemoteDataSource: sl(),
    ),
  );

  // datasources
  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(apiBaseHelper: sl()),
  );
}
