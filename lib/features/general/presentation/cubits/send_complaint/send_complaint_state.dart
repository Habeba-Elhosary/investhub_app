part of 'send_complaint_cubit.dart';

sealed class SendComplaintState extends Equatable {
  const SendComplaintState();

  @override
  List<Object> get props => <Object>[];
}

final class SendComplainInitial extends SendComplaintState {}

final class SendComplainLoading extends SendComplaintState {}

final class SendComplainError extends SendComplaintState {
  final String message;
  const SendComplainError({required this.message});
}

final class SendComplainSuccess extends SendComplaintState {}
