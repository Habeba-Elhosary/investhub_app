part of 'get_banks_cubit.dart';

sealed class GetBanksState extends Equatable {
  const GetBanksState();

  @override
  List<Object> get props => <Object>[];
}

final class GetBanksInitial extends GetBanksState {}

final class GetBanksLoading extends GetBanksState {}

final class GetBanksError extends GetBanksState {
  final String message;
  const GetBanksError({required this.message});
}

final class GetBanksSuccess extends GetBanksState {
  final List<Bank> banks;
  const GetBanksSuccess({required this.banks});

  @override
  List<Object> get props => <Object>[banks];
}
