part of 'send_otp_cubit.dart';

sealed class SendOtpState extends Equatable {
  const SendOtpState();

  @override
  List<Object> get props => <Object>[];
}

final class SendOtpInitial extends SendOtpState {}

final class SendOtpLoading extends SendOtpState {}

final class SendOtpSuccess extends SendOtpState {}

final class SendOtpError extends SendOtpState {
  final String message;

  const SendOtpError({required this.message});
}

