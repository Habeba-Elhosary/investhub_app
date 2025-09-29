import 'package:investhub_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:investhub_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:investhub_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:investhub_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:investhub_app/features/auth/domain/usecases/auto_login_usecase.dart';
import 'package:investhub_app/features/auth/domain/usecases/create_new_password_usecase.dart';
import 'package:investhub_app/features/auth/domain/usecases/detect_user_by_phone_usecase.dart';
import 'package:investhub_app/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:investhub_app/features/auth/domain/usecases/get_user_profile_usecase.dart';
import 'package:investhub_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:investhub_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:investhub_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:investhub_app/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:investhub_app/features/auth/domain/usecases/verify_code_usecase.dart';
import 'package:investhub_app/features/auth/presentation/cubits/auto_login/auto_login_cubit.dart';
import 'package:investhub_app/features/auth/presentation/cubits/create_new_password/create_new_password_cubit.dart';
import 'package:investhub_app/features/auth/presentation/cubits/detect_user_by_phone/detect_user_by_phone_cubit.dart';
import 'package:investhub_app/features/auth/presentation/cubits/forget_password/forget_password_cubit.dart';
import 'package:investhub_app/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:investhub_app/features/auth/presentation/cubits/logout/logout_cubit.dart';
import 'package:investhub_app/features/auth/presentation/cubits/register/register_cubit.dart';
import 'package:investhub_app/features/auth/presentation/cubits/send_otp/send_otp_cubit.dart';
import 'package:investhub_app/features/auth/presentation/cubits/verification_code/verification_code_cubit.dart';
import 'package:investhub_app/injection_container.dart';

void initAuthInjection() async {
  //Cubits
  sl.registerFactory(() => LoginCubit(loginUsecase: sl()));
  sl.registerFactory(() => RegisterCubit(registerUsecase: sl()));

  sl.registerLazySingleton(() => AutoLoginCubit(autoLoginUsecase: sl()));

  sl.registerFactory(() => ForgetPasswordCubit(forgetPasswordUsecase: sl()));
  sl.registerFactory(
    () => CreateNewPasswordCubit(createNewPasswordUsecase: sl()),
  );
  sl.registerFactory(() => SendOtpCubit(sendOtpUsecase: sl()));
  sl.registerFactory(() => VerfiyCodeCubit(verfiyCodeUsecase: sl()));
  sl.registerFactory(() => LogoutCubit(logoutUsecase: sl()));
  sl.registerFactory<DetectUserByPhoneCubit>(
    () => DetectUserByPhoneCubit(detectUserByPhoneUsecase: sl()),
  );

  // usecase
  sl.registerLazySingleton(() => LoginUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => RegisterUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => ForgetPasswordUsecase(authRepository: sl()));
  sl.registerLazySingleton(
    () => CreateNewPasswordUsecase(authRepository: sl()),
  );
  sl.registerLazySingleton(() => GetUserProfileUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => SendOtpUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => VerifyCodeUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => LogoutUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => AutoLoginUsecase(authRepository: sl()));
  sl.registerLazySingleton<DetectUserByPhoneUsecase>(
    () => DetectUserByPhoneUsecase(repository: sl()),
  );
  // repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      local: sl(),
      authRemoteDatasource: sl(),
      firebaseMessaging: sl(),
    ),
  );
  // data sources

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(cacheService: sl()),
  );
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(apiBaseHelper: sl()),
  );
}
