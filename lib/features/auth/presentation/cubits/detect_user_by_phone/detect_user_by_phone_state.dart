part of 'detect_user_by_phone_cubit.dart';

sealed class DetectUserByPhoneState extends Equatable {
  const DetectUserByPhoneState();

  @override
  List<Object> get props => [];
}

final class DetectUserByPhoneInitial extends DetectUserByPhoneState {}

final class DetectUserByPhoneLoading extends DetectUserByPhoneState {}

final class DetectUserByPhoneError extends DetectUserByPhoneState {
  final String message;

  const DetectUserByPhoneError({required this.message});
}

final class DetectUserByPhoneHasActiveUser extends DetectUserByPhoneState {
  final DetectUserResponse detectUserResponse;

  const DetectUserByPhoneHasActiveUser({required this.detectUserResponse});
}

final class DetectUserByPhoneHasInactiveUser extends DetectUserByPhoneState {
  final DetectUserResponse detectUserResponse;

  const DetectUserByPhoneHasInactiveUser({required this.detectUserResponse});
}
