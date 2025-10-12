import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/widgets/toast.dart';
import 'package:investhub_app/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordUsecase resetPasswordUsecase;

  ResetPasswordCubit({required this.resetPasswordUsecase})
    : super(ResetPasswordInitial());

  Future<void> resetPasswordEvent({
    required String phone,
    required String password,
    required String resetToken,
  }) async {
    print('ResetPasswordCubit: Starting reset password event');
    print('ResetPasswordCubit: Phone: $phone');
    print('ResetPasswordCubit: ResetToken: $resetToken');
    emit(ResetPasswordLoading());

    final Either<Failure, String> failOrSuccess = await resetPasswordUsecase(
      ResetPasswordParams(
        phone: phone,
        password: password,
        resetToken: resetToken,
      ),
    );

    failOrSuccess.fold(
      (Failure fail) {
        showErrorToast(fail.message);
        emit(ResetPasswordError(message: fail.message));
      },
      (String message) {
        showSucessToast(message);
        emit(ResetPasswordSuccess());
        appNavigator.popToFrist();
      },
    );
  }
}
