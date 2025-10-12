import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/features/auth/domain/entities/change_password_params.dart';
import 'package:investhub_app/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUsecase changePasswordUsecase;

  ChangePasswordCubit({required this.changePasswordUsecase})
    : super(ChangePasswordInitial());

  Future<void> changePasswordEvent({
    required String oldPassword,
    required String password,
    required String confirmPassword,
  }) async {
    if (state is ChangePasswordLoading) return;

    emit(ChangePasswordLoading());

    final result = await changePasswordUsecase(
      ChangePasswordParams(
        oldPassword: oldPassword,
        password: password,
        confirmPassword: confirmPassword,
      ),
    );

    result.fold(
      (Failure failure) {
        final errorMessage = failure.message.isNotEmpty
            ? failure.message
            : LocaleKeys.errorsMessage_something_went_wrong.tr();
        emit(ChangePasswordError(message: errorMessage));
      },
      (String message) {
        final successMessage = message.isNotEmpty
            ? message
            : LocaleKeys.auth_password_changed_successfully.tr();
        emit(ChangePasswordSuccess(message: successMessage));
      },
    );
  }
}
