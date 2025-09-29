import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/core/widgets/toast.dart';
import 'package:investhub_app/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:investhub_app/features/auth/presentation/pages/verify_otp/verify_otp__timer_stream.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'send_otp_state.dart';

class SendOtpCubit extends Cubit<SendOtpState> {
  final SendOtpUsecase sendOtpUsecase;
  SendOtpCubit({required this.sendOtpUsecase}) : super(SendOtpInitial());

  Future<void> sendOTPEvent() async {
    emit(SendOtpLoading());
    final Either<Failure, Unit> response = await sendOtpUsecase(NoParams());
    response.fold(
      (Failure failure) {
        emit(SendOtpError(message: failure.message));
        showErrorToast(failure.message);
      },
      (Unit unit) {
        showSucessToast(LocaleKeys.auth_otp_sent_successfully.tr());
        VerificationCodeTimerStream.counterValue = 60;
        VerificationCodeTimerStream.autoDecrement();
        emit(SendOtpSuccess());
      },
    );
  }
}
