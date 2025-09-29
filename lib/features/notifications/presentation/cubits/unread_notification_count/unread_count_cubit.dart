import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/core/util/request_status.dart';
import 'package:investhub_app/core/widgets/toast.dart';
import 'package:investhub_app/features/notifications/domain/usecases/get_unread_notification_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'unread_count_state.dart';

class UnreadCountCubit extends Cubit<UnreadCountState> {
  final GetUnreadNotificaCountUsecase getUnreadNotificationUsecase;
  UnreadCountCubit({required this.getUnreadNotificationUsecase})
    : super(const UnreadCountState());

  Future<void> getUnreadCount() async {
    emit(state.copyWith(requestStatus: RequestStatus.loading));
    final Either<Failure, int> result = await getUnreadNotificationUsecase(
      NoParams(),
    );

    result.fold(
      (Failure fail) {
        emit(state.copyWith(requestStatus: RequestStatus.error));
        showErrorToast(fail.message);
      },
      (int count) => emit(
        state.copyWith(
          unreadCount: count,
          requestStatus: RequestStatus.success,
        ),
      ),
    );
  }

  void markAllAsRead() {
    emit(state.copyWith(unreadCount: 0));
  }
}
