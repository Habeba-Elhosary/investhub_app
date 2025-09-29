import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/widgets/toast.dart';
import 'package:investhub_app/features/auth/domain/usecases/create_new_password_usecase.dart';
import 'package:investhub_app/features/auth/presentation/pages/sign_in/sign_in_screen.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_new_password_state.dart';

class CreateNewPasswordCubit extends Cubit<CreateNewPasswordState> {
  final CreateNewPasswordUsecase createNewPasswordUsecase;
  CreateNewPasswordCubit({required this.createNewPasswordUsecase})
    : super(CreateNewPasswordInitial());

  Future<void> createNewPasswordEvent({
    required CreateNewPasswordParams createNewPasswordParams,
  }) async {
    emit(CreateNewPasswordLoading());
    final Either<Failure, Unit> result = await createNewPasswordUsecase(
      createNewPasswordParams,
    );
    result.fold(
      (Failure failure) {
        showErrorToast(failure.message);
        emit(CreateNewPasswordError(message: failure.message));
      },
      (_) {
        showSucessToast(LocaleKeys.auth_password_changed_successfully.tr());
        appNavigator.popUtill(screen: const SignInScreen());
        emit(CreateNewPasswordSuccess());
      },
    );
  }
}
