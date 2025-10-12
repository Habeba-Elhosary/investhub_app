// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../util/api_base_helper.dart';
import 'exceptions.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});
  @override
  List<Object> get props => <Object>[];
}

class ServerFailure extends Failure {
  final CodeStatus code;
  final Map<String, dynamic>? errorMap;
  const ServerFailure({
    required super.message,
    this.errorMap,
    this.code = CodeStatus.defaultCode,
  });
  factory ServerFailure.formServerException(ServerException exception) {
    return ServerFailure(
      message: exception.message,
      errorMap: exception.errorMap,
      code: exception.code,
    );
  }
}

class TraderAlreadyExistFailure extends Failure {
  final int id;
  const TraderAlreadyExistFailure({required super.message, required this.id});
  factory TraderAlreadyExistFailure.formException(
    TraderAlreadyExistException exception,
  ) {
    return TraderAlreadyExistFailure(
      message: exception.message,
      id: exception.id,
    );
  }
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

class EmpolyeeNotWorkingFailure extends Failure {
  const EmpolyeeNotWorkingFailure({super.message = ''});
}

class OldVersionFailure extends Failure {
  const OldVersionFailure({super.message = ''});
}

class AddressFailure extends Failure {
  const AddressFailure({required super.message});
}

class AuthFailure extends Failure {
  const AuthFailure() : super(message: '');
}

class NoCachedUserFailure extends Failure {
  const NoCachedUserFailure({required super.message});
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({super.message = 'Unauthorized'});
}

class ProductAlreadyExistInCartFailure extends Failure {
  const ProductAlreadyExistInCartFailure({required super.message});
}

class OtpVerificationRequiredFailure extends Failure {
  final String otpToken;
  const OtpVerificationRequiredFailure({
    required super.message,
    required this.otpToken,
  });
}
