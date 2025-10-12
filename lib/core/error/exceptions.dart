import '../util/api_base_helper.dart';

class ServerException implements Exception {
  final String message;
  final CodeStatus code;
  final Map<String, dynamic>? errorMap;
  ServerException({
    this.errorMap,
    required this.message,
    this.code = CodeStatus.defaultCode,
  });
}

class TraderAlreadyExistException implements Exception {
  final String message;
  final int id;
  TraderAlreadyExistException({required this.message, required this.id});
  factory TraderAlreadyExistException.fromJson(Map<String, dynamic> json) =>
      TraderAlreadyExistException(message: json['message'], id: json['id']);
}

class OldVersionException implements Exception {}

class CacheException implements Exception {}

class AuthException implements Exception {
  final String message;
  AuthException({required this.message});
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException({required this.message});
}

class NoCacheOrderException implements Exception {}

class CacheUserAcssesToken implements Exception {}

class ResetPasswordException implements Exception {}

class OrderTypeException implements Exception {}

class StatusException implements Exception {
  final String message;
  StatusException({required this.message});
}

class ProductAlreadyExistInCartException implements Exception {
  final String message;
  ProductAlreadyExistInCartException({required this.message});
}

class OtpVerificationRequiredException implements Exception {
  final String message;
  final String otpToken;
  OtpVerificationRequiredException({
    required this.message,
    required this.otpToken,
  });
}
