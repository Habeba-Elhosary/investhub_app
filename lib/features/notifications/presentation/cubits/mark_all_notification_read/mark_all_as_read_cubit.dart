import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/core/util/request_status.dart';
import 'package:investhub_app/core/widgets/toast.dart';
import 'package:investhub_app/features/notifications/domain/usecases/mark_all_notification_as_read_usecase.dart';
import 'package:investhub_app/features/notifications/presentation/cubits/all_notification/all_notification_cubit.dart';
import 'package:investhub_app/features/notifications/presentation/cubits/unread_notification_count/unread_count_cubit.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'mark_all_as_read_state.dart';

class MarkAllAsReadCubit extends Cubit<MarkAllAsReadState> {
  final MarkAllNotificationAsReadUsecase markAllNotificationsAsRead;
  MarkAllAsReadCubit({required this.markAllNotificationsAsRead})
    : super(const MarkAllAsReadState());

  Future<void> markAllAsReadEvent() async {
    emit(state.copyWith(requestStatus: RequestStatus.loading));
    final Either<Failure, Unit> result = await markAllNotificationsAsRead(
      NoParams(),
    );
    result.fold(
      (Failure fail) {
        showErrorToast(fail.message);
        emit(state.copyWith(requestStatus: RequestStatus.error));
      },
      (Unit r) {
        sl<AllNotificationsCubit>().markAllAsRead();
        sl<UnreadCountCubit>().markAllAsRead();
        showSucessToast(LocaleKeys.all_notifications_marked_as_read.tr());
        emit(state.copyWith(requestStatus: RequestStatus.success));
      },
    );
  }
}
