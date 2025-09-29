import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/util/request_status.dart';
import 'package:investhub_app/features/home/domain/repositories/home_repository.dart';
import 'package:investhub_app/features/notifications/domain/entities/notification_response.dart';
import 'package:investhub_app/features/notifications/domain/usecases/get_all_notification_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'all_notification_state.dart';

class AllNotificationsCubit extends Cubit<AllNotificationsState> {
  final GetAllNotificationsUseCase getAllNotificationsUseCase;
  AllNotificationsCubit({required this.getAllNotificationsUseCase})
    : super(
        const AllNotificationsState(
          allRequestStatus: RequestStatus.initial,
          paginationRequestStatus: RequestStatus.initial,
          notifications: <NotificationEntity>[],
          currentPage: 1,
          lastPage: 1,
        ),
      );

  final List<NotificationEntity> notifications = <NotificationEntity>[];
  int unreadNotificationsCount = 0;
  ScrollController scrollController = ScrollController();

  void initScoll() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        loadMoreNotifications();
      }
    });
  }

  Future<void> getNotificationsForFirstTime() async {
    emit(
      state.copyWith(
        allRequestStatus: RequestStatus.loading,
        notifications: <NotificationEntity>[],
        currentPage: 1,
        lastPage: 1,
      ),
    );

    final Either<Failure, AllNotificationsResponse> result =
        await getAllNotificationsUseCase(
          PaginationParams(page: state.currentPage),
        );
    result.fold(
      (Failure failure) => emit(
        state.copyWith(
          allRequestStatus: RequestStatus.error,
          generalErrorMessage: failure.message,
        ),
      ),
      (AllNotificationsResponse response) => emit(
        state.copyWith(
          allRequestStatus: RequestStatus.success,
          lastPage: response.meta.lastPage,
          notifications: response.data,
        ),
      ),
    );
  }

  Future<void> loadMoreNotifications() async {
    if (state.currentPage >= state.lastPage) {
      return;
    }
    emit(
      state.copyWith(
        currentPage: state.currentPage + 1,
        paginationRequestStatus: RequestStatus.loading,
      ),
    );
    final Either<Failure, AllNotificationsResponse> result =
        await getAllNotificationsUseCase(
          PaginationParams(page: state.currentPage),
        );
    result.fold(
      (Failure failure) => emit(
        state.copyWith(
          currentPage: state.currentPage - 1,
          paginationRequestStatus: RequestStatus.error,
          paginationErrorMessage: failure.message,
        ),
      ),
      (AllNotificationsResponse response) => emit(
        state.copyWith(
          paginationRequestStatus: RequestStatus.success,
          notifications: List.from(state.notifications + response.data),
          currentPage: state.currentPage,
          lastPage: response.meta.lastPage,
        ),
      ),
    );
  }

  void markAllAsRead() {
    emit(state.copyWith(allRequestStatus: RequestStatus.initial));

    final List<NotificationEntity> updatedNotifications = state.notifications
        .map((notification) => notification.copyWith(isSeen: true))
        .toList();

    emit(
      state.copyWith(
        allRequestStatus: RequestStatus.success,
        notifications: updatedNotifications,
      ),
    );
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}
