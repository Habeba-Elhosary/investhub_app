part of 'static_data_cubit.dart';

sealed class StaticDataState extends Equatable {
  const StaticDataState();

  @override
  List<Object> get props => [];
}

final class StaticDataInitial extends StaticDataState {}

final class StaticDataLoaded extends StaticDataState {
  final String data;
  const StaticDataLoaded({required this.data});
}

final class StaticDataError extends StaticDataState {
  final String message;
  const StaticDataError({required this.message});
}

final class StaticDataLoading extends StaticDataState {}
