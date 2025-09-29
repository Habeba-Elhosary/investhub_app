import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/widgets/toast.dart';
import 'package:investhub_app/features/auth/data/models/auth_response.dart';
import 'package:investhub_app/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:investhub_app/features/auth/presentation/pages/verify_otp/verify_otp_screen.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUsecase forgetPasswordUsecase;
  ForgetPasswordCubit({required this.forgetPasswordUsecase})
    : super(FrogetPasswordInitial());

  Future<void> forgetPasswordEvent({required String phone}) async {
    emit(ForgetPasswordLoading());

    final Either<Failure, AuthResponse> failOrUser =
        await forgetPasswordUsecase(PhoneParams(phone: phone));
    failOrUser.fold(
      (Failure fail) {
        showErrorToast(fail.message);
        emit(FrogetPasswordError(message: fail.message));
      },
      (AuthResponse user) {
        emit(ForgetPasswordSuccess());
        appNavigator.popToFrist();
        appNavigator.push(screen: const OTPVerficationScreen());
      },
    );
  }
}
