import 'package:investhub_app/core/constant/styles/theme/theme_cubit.dart';
import 'package:investhub_app/core/services/cache_service.dart';
import 'package:investhub_app/core/util/api_base_helper.dart';
import 'package:investhub_app/core/util/navigator.dart';
import 'package:investhub_app/features/auth/auth_injection.dart';
import 'package:investhub_app/features/auth/presentation/cubits/auto_login/auto_login_cubit.dart';
import 'package:investhub_app/features/cart/cart_injection.dart';
import 'package:investhub_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:investhub_app/features/general/general_injection.dart';
import 'package:investhub_app/features/home/home_injection.dart';
import 'package:investhub_app/features/notifications/notifications_injection.dart';
import 'package:investhub_app/features/notifications/presentation/cubits/all_notification/all_notification_cubit.dart';
import 'package:investhub_app/features/notifications/presentation/cubits/mark_all_notification_read/mark_all_as_read_cubit.dart';
import 'package:investhub_app/features/notifications/presentation/cubits/unread_notification_count/unread_count_cubit.dart';
import 'package:investhub_app/features/orders/order_injection.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

abstract class ServiceLocator {
  static Future<void> init() async {
    // features
    initAuthInjection();
    initHomeInjection();
    initCartInjection();
    initOrderInjection();
    initGeneralInjection();
    initNotificationsInjection();
    // core
    injectDioHelper();
    _injectAppNavigator();
    _injectCacheService();
    _injectAppTheme();
    _injectFirbaseMessaging();
    injectSharedPreferences();
    injectSecureStorage();
  }

  static List<BlocProvider<StateStreamableSource<Object?>>>
  globalBlocProviders = <BlocProvider<StateStreamableSource<Object?>>>[
    BlocProvider<ThemeCubit>(create: (_) => sl<ThemeCubit>()),
    BlocProvider<AutoLoginCubit>(
      create: (_) => sl<AutoLoginCubit>()..fAutoLogin(),
    ),
    // notifications
    BlocProvider<MarkAllAsReadCubit>(create: (_) => sl<MarkAllAsReadCubit>()),
    BlocProvider<AllNotificationsCubit>(
      create: (_) => sl<AllNotificationsCubit>(),
    ),
    BlocProvider<CartCubit>(create: (_) => sl<CartCubit>()),
    BlocProvider<UnreadCountCubit>(
      create: (_) => sl<UnreadCountCubit>()..getUnreadCount(),
    ),
  ];
}

void _injectAppTheme() {
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
}

void injectDioHelper() {
  sl.registerLazySingleton<ApiBaseHelper>(() => ApiBaseHelper(dio: sl()));
  sl.registerLazySingleton(
    () => Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
        sendTimeout: const Duration(milliseconds: 60000),
        connectTimeout: const Duration(milliseconds: 60000),
        receiveTimeout: const Duration(milliseconds: 60000),
      ),
    ),
  );
}

void _injectAppNavigator() {
  sl.registerLazySingleton<AppNavigator>(() => AppNavigator());
}

void _injectCacheService() {
  sl.registerLazySingleton<CacheService>(() => CacheServiceImpl());
}

void _injectFirbaseMessaging() async {
  sl.registerLazySingleton<FirebaseMessaging>(() => FirebaseMessaging.instance);
}

void injectSecureStorage() async {
  AndroidOptions androidOptions = const AndroidOptions(
    encryptedSharedPreferences: true,
  );
  final FlutterSecureStorage storage = FlutterSecureStorage(
    aOptions: androidOptions,
  );
  sl.registerLazySingleton<FlutterSecureStorage>(() => storage);
}

void injectSharedPreferences() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

ApiBaseHelper get apiBaseHelper => sl<ApiBaseHelper>();

AppNavigator get appNavigator => sl<AppNavigator>();
