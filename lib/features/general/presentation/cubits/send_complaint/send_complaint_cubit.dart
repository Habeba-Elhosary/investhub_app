import 'package:investhub_app/core/entities/status_response.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/widgets/toast.dart';
import 'package:investhub_app/features/general/domain/usecases/send_complaint_usecase.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'send_complaint_state.dart';

class SendComplaintCubit extends Cubit<SendComplaintState> {
  final SendComplaintUsecase sendComplaintUsecase;
  SendComplaintCubit({required this.sendComplaintUsecase})
    : super(SendComplainInitial());

  Future<void> sendComplainEvent(String content) async {
    emit(SendComplainLoading());
    final Either<Failure, StatusResponse> result = await sendComplaintUsecase(
      content,
    );
    result.fold(
      (Failure fail) {
        showErrorToast(fail.message);
        emit(SendComplainError(message: fail.message));
      },
      (StatusResponse statusResponse) {
        showSucessToast(statusResponse.message);
        appNavigator.popToFrist();
        emit(SendComplainSuccess());
      },
    );
  }
}
