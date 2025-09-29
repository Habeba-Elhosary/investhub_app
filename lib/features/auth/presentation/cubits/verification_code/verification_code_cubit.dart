import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/widgets/toast.dart';
import 'package:investhub_app/features/auth/domain/usecases/verify_code_usecase.dart';
import 'package:investhub_app/features/auth/presentation/pages/reset_password/reset_password.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verification_code_state.dart';

class VerfiyCodeCubit extends Cubit<VerfiyCodeState> {
  final VerifyCodeUsecase verfiyCodeUsecase;

  VerfiyCodeCubit({required this.verfiyCodeUsecase})
    : super(VerfiyCodeInitial());

  Future<void> verfiyCodeEvent({required String code}) async {
    emit(VerfiyCodeLoading());
    final Either<Failure, Unit> failOrSuccess = await verfiyCodeUsecase(code);

    failOrSuccess.fold(
      (Failure l) {
        emit(VerfiyCodeError(message: l.message));
        showErrorToast(l.message);
      },
      (Unit r) {
        appNavigator.pushReplacement(screen: const ResetPasswordScreen());
        emit(VerfiyCodeSuccess());
      },
    );
  }
}
