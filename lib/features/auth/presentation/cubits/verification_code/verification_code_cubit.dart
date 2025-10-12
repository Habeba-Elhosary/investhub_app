import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/widgets/toast.dart';
import 'package:investhub_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:investhub_app/features/auth/domain/usecases/verify_code_usecase.dart';
import 'package:investhub_app/features/auth/domain/usecases/verify_forget_password_otp_usecase.dart';
import 'package:investhub_app/features/auth/presentation/pages/reset_password/reset_password.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verification_code_state.dart';

enum VerificationContext { login, passwordReset }

class VerfiyCodeCubit extends Cubit<VerfiyCodeState> {
  final VerifyCodeUsecase verfiyCodeUsecase;
  final VerifyForgetPasswordOtpUsecase verifyForgetPasswordOtpUsecase;
  final AuthLocalDataSource localDataSource;
  String? otpToken;
  String? phone;
  VerificationContext context;

  VerfiyCodeCubit({
    required this.verfiyCodeUsecase,
    required this.verifyForgetPasswordOtpUsecase,
    required this.localDataSource,
    this.context = VerificationContext.passwordReset,
  }) : super(VerfiyCodeInitial());

  void setOtpToken(String token) async {
    otpToken = token;
    await localDataSource.cacheUserOtpToken(token: token);
  }

  void setPhone(String phoneNumber) {
    print('VerfiyCodeCubit: Setting phone to: $phoneNumber');
    phone = phoneNumber;
  }

  Future<void> verfiyCodeEvent({required String code}) async {
    print('VerfiyCodeCubit: Starting verification with code: $code');
    print('VerfiyCodeCubit: Context: $context');
    print('VerfiyCodeCubit: Phone: $phone');
    print('VerfiyCodeCubit: OTPToken: $otpToken');

    emit(VerfiyCodeLoading());

    Either<Failure, String> failOrSuccess;

    if (context == VerificationContext.passwordReset &&
        phone != null &&
        otpToken != null) {
      print('VerfiyCodeCubit: Using forget password OTP verification');
      // Use forget password OTP verification
      failOrSuccess = await verifyForgetPasswordOtpUsecase(
        VerifyForgetPasswordOtpParams(
          phone: phone!,
          otp: code,
          otpToken: otpToken!,
        ),
      );
    } else {
      print('VerfiyCodeCubit: Using regular OTP verification');
      // Use regular OTP verification
      failOrSuccess = await verfiyCodeUsecase(code);
    }

    failOrSuccess.fold(
      (Failure l) {
        emit(VerfiyCodeError(message: l.message));
        showErrorToast(l.message);
      },
      (String result) {
        print('VerfiyCodeCubit: Verification successful, result: $result');
        print('VerfiyCodeCubit: Result length: ${result.length}');
        print('VerfiyCodeCubit: Result isEmpty: ${result.isEmpty}');
        if (context == VerificationContext.login) {
          print('VerfiyCodeCubit: Login context, popping to first');
          appNavigator.popToFrist();
        } else {
          print(
            'VerfiyCodeCubit: Password reset context, navigating to reset password screen',
          );
          print('VerfiyCodeCubit: ResetToken: $result, Phone: $phone');
          // For password reset, pass the reset token and phone to the reset password screen
          appNavigator.pushReplacement(
            screen: ResetPasswordScreen(resetToken: result, phone: phone),
          );
        }

        emit(VerfiyCodeSuccess(message: result));
      },
    );
  }
}
