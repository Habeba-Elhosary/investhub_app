import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/widgets/toast.dart';
import 'package:investhub_app/features/auth/data/models/detect_user_response.dart';
import 'package:investhub_app/features/auth/domain/usecases/detect_user_by_phone_usecase.dart';
import 'package:investhub_app/features/auth/presentation/pages/verify_otp/verify_otp_screen.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'detect_user_by_phone_state.dart';

class DetectUserByPhoneCubit extends Cubit<DetectUserByPhoneState> {
  final DetectUserByPhoneUsecase detectUserByPhoneUsecase;

  DetectUserByPhoneCubit({required this.detectUserByPhoneUsecase})
    : super(DetectUserByPhoneInitial());

  String? phone;

  Future<void> detectUserByPhoneEvent({required String phone}) async {
    emit(DetectUserByPhoneLoading());

    final Either<Failure, DetectUserResponse> failOrUser =
        await detectUserByPhoneUsecase(phone);
    failOrUser.fold(
      (Failure fail) {
        showErrorToast(fail.message);
        emit(DetectUserByPhoneError(message: fail.message));
      },
      (DetectUserResponse user) {
        this.phone = phone;
        if (user.data.isActive) {
          emit(DetectUserByPhoneHasActiveUser(detectUserResponse: user));
        } else {
          emit(DetectUserByPhoneHasInactiveUser(detectUserResponse: user));
          appNavigator.push(screen: const OTPVerficationScreen());
        }
      },
    );
  }

  void deleteNumber() {
    phone = null;
    emit(DetectUserByPhoneInitial());
  }
}
