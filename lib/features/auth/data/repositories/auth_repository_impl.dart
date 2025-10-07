import 'dart:io';
import 'package:investhub_app/core/entities/status_response.dart';
import 'package:investhub_app/core/error/exceptions.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:investhub_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:investhub_app/features/auth/data/models/auth_response.dart';
import 'package:investhub_app/features/auth/data/models/detect_user_response.dart';
import 'package:investhub_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRemoteDatasource authRemoteDatasource;
  AuthLocalDataSource local;

  AuthRepositoryImpl({required this.authRemoteDatasource, required this.local});

  @override
  Future<Either<Failure, User>> autoLogin() async {
    try {
      final (String phone, String password) = await local.getUserCredentials();
      final AuthResponse authResponse = await authRemoteDatasource.login(
        phone: phone,
        password: password,
      );
      await local.cacheUser(authResponse.data);
      await local.cacheUserAccessToken(token: authResponse.data.token);
      return right(authResponse.data);
    } on ServerException catch (error) {
      try {
        final User cachedUser = await local.getCacheUser();
        if (!(await hasInternetConnection())) {
          return right(cachedUser);
        }
      } on CacheException {
        return left(const CacheFailure(message: 'Not Authenticated'));
      }
      return left(ServerFailure.formServerException(error));
    } on CacheException {
      return left(const CacheFailure(message: 'Not Authenticated'));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> login({
    required String phone,
    required String password,
  }) async {
    try {
      final AuthResponse data = await authRemoteDatasource.login(
        phone: phone,
        password: password,
      );
      await local.cacheUserAccessToken(token: data.data.token);
      await local.cacheUserCredentials(phone: phone, password: password);
      local.cacheUser(data.data);
      return right(data);
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> register({
    required RegisterParams params,
  }) async {
    try {
      final AuthResponse data = await authRemoteDatasource.register(
        params: params,
      );
      await local.cacheUserOtpToken(token: data.data.otpToken);
      await local.cacheUserAccessToken(token: data.data.token);
      return right(data);
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }

  @override
  Future<Either<Failure, Unit>> createNewPassword({
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final String token = await local.getUserAccessToken();
      await authRemoteDatasource.createNewPassword(
        password: password,
        passwordConfirmation: passwordConfirmation,
        token: token,
      );
      return right(unit);
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> forgetPassword({
    required String phone,
  }) async {
    try {
      final AuthResponse data = await authRemoteDatasource.forgetPassword(
        phone: phone,
      );
      return right(data);
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> getUserProfile() async {
    try {
      final String token = await local.getUserAccessToken();
      final AuthResponse data = await authRemoteDatasource.getUserProfile(
        token,
      );
      return right(data);
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }

  @override
  Future<Either<Failure, StatusResponse>> logout() async {
    try {
      final String token = await local.getUserAccessToken();

      final StatusResponse statusResponse = await authRemoteDatasource.logout(
        token: token,
      );
      await local.clearData();

      return right(statusResponse);
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }

  @override
  Future<Either<Failure, Unit>> sendOTPCode() async {
    try {
      final String token = await local.getUserAccessToken();
      await authRemoteDatasource.sendOTPCode(token: token);
      return right(unit);
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyCode(String code) async {
    try {
      final String otpToken = await local.getCacheUserOtpToken();
      final String token = await local.getUserAccessToken();
      await authRemoteDatasource.verifyCode(
        code: code,
        otpToken: otpToken,
        token: token,
      );
      return right(unit);
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }

  @override
  Future<Either<Failure, DetectUserResponse>> detectUser(String phone) async {
    try {
      final DetectUserResponse data = await authRemoteDatasource.detectUser(
        phone,
      );
      await local.cacheUserAccessToken(token: data.data.token);
      return right(data);
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }

  Future<bool> hasInternetConnection() async {
    try {
      final List<InternetAddress> result = await InternetAddress.lookup(
        'google.com',
      );
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
