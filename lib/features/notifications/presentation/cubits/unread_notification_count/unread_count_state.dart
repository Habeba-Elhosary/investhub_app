part of 'unread_count_cubit.dart';




class UnreadCountState extends Equatable {
  final RequestStatus requestStatus;
  final int unreadCount;
  const UnreadCountState({
    this.requestStatus = RequestStatus.initial,
    this.unreadCount = 0,
  });

  UnreadCountState copyWith({RequestStatus? requestStatus, int? unreadCount}) {
    return UnreadCountState(
      requestStatus: requestStatus ?? this.requestStatus,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  @override
  List<Object> get props => <Object>[requestStatus, unreadCount];
}
