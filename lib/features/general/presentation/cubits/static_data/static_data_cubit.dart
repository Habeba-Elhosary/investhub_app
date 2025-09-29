import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/features/general/domain/usecases/get_static_data_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'static_data_state.dart';

class StaticDataCubit extends Cubit<StaticDataState> {
  final GetStaticDataUsecase getStaticDataUsecase;
  StaticDataCubit({required this.getStaticDataUsecase})
    : super(StaticDataInitial());

  Future<void> getStaticDataEvent(String type) async {
    emit(StaticDataLoading());
    final Either<Failure, String> result = await getStaticDataUsecase(type);
    result.fold(
      (Failure fail) {
        emit(StaticDataError(message: fail.message));
      },
      (String data) {
        emit(StaticDataLoaded(data: data));
      },
    );
  }
}
