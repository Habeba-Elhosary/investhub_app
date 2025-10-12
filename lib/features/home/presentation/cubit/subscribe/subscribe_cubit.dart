import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/widgets/toast.dart';
import 'package:investhub_app/features/home/domain/entities/subscribe_response.dart';
import 'package:investhub_app/features/home/domain/usecases/subscribe_usecase.dart';

part 'subscribe_state.dart';

class SubscribeCubit extends Cubit<SubscribeState> {
  final SubscribeUsecase subscribeUsecase;

  SubscribeCubit({required this.subscribeUsecase}) : super(SubscribeInitial());

  Future<void> subscribeEvent({required int subscriptionId}) async {
    if (state is SubscribeLoading) return;
    emit(SubscribeLoading());
    final Either<Failure, SubscribeResponse> result = await subscribeUsecase(
      subscriptionId: subscriptionId,
    );
    result.fold(
      (Failure fail) {
        final errorMessage = fail.message.isNotEmpty
            ? fail.message
            : 'حدث خطأ أثناء الاشتراك';
        showErrorToast(errorMessage);
        emit(SubscribeError(message: errorMessage));
      },
      (SubscribeResponse response) {
        final successMessage = response.message?.isNotEmpty == true
            ? response.message!
            : 'تم الاشتراك بنجاح';
        showSucessToast(successMessage);
        emit(SubscribeSuccess(message: successMessage));
      },
    );
  }
}
