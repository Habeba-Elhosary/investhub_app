part of 'all_notification_cubit.dart';

class AllNotificationsState extends Equatable {
  final RequestStatus allRequestStatus;
  final RequestStatus paginationRequestStatus;
  final List<NotificationEntity> notifications;
  final String generalErrorMessage;
  final String paginationErrorMessage;
  final int currentPage;
  final int lastPage;

  const AllNotificationsState({
    this.allRequestStatus = RequestStatus.initial,
    this.paginationRequestStatus = RequestStatus.initial,
    this.notifications = const <NotificationEntity>[],
    this.generalErrorMessage = '',
    this.paginationErrorMessage = '',
    this.currentPage = 1,
    this.lastPage = 1,
  });

  @override
  List<Object?> get props => <Object?>[
    allRequestStatus,
    paginationRequestStatus,
    List<NotificationEntity>.from(notifications),
    generalErrorMessage,
    paginationErrorMessage,
    currentPage,
    lastPage,
  ];

  AllNotificationsState copyWith({
    RequestStatus? allRequestStatus,
    RequestStatus? paginationRequestStatus,
    List<NotificationEntity>? notifications,
    String? generalErrorMessage,
    String? paginationErrorMessage,
    int? currentPage,
    int? lastPage,
    String? searchText,
  }) {
    return AllNotificationsState(
      allRequestStatus: allRequestStatus ?? this.allRequestStatus,
      paginationRequestStatus:
          paginationRequestStatus ?? this.paginationRequestStatus,
      notifications: notifications ?? this.notifications,
      paginationErrorMessage:
          paginationErrorMessage ?? this.paginationErrorMessage,
      generalErrorMessage: generalErrorMessage ?? this.generalErrorMessage,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
    );
  }
}
