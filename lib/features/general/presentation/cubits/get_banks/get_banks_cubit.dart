import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/core/widgets/toast.dart';
import 'package:investhub_app/features/general/domain/entities/banks_response.dart';
import 'package:investhub_app/features/general/domain/usecases/get_banks_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'get_banks_state.dart';

class GetBanksCubit extends Cubit<GetBanksState> {
  final GetBanksUsecase banksUseCase;
  GetBanksCubit({required this.banksUseCase}) : super(GetBanksInitial());

  List<Bank> banks = [];

  Future<void> getBanksEvent() async {
    emit(GetBanksLoading());
    final Either<Failure, BanksResponse> result = await banksUseCase(
      NoParams(),
    );
    result.fold(
      (Failure fail) {
        showErrorToast(fail.message);
        emit(GetBanksError(message: fail.message));
      },
      (BanksResponse statusResponse) {
        emit(GetBanksSuccess(banks: statusResponse.data));
        banks = statusResponse.data;
      },
    );
  }
}
