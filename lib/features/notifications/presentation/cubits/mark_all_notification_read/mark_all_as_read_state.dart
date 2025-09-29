part of 'mark_all_as_read_cubit.dart';

class MarkAllAsReadState extends Equatable {
  const MarkAllAsReadState({this.requestStatus = RequestStatus.initial});
  final RequestStatus requestStatus;

  MarkAllAsReadState copyWith({RequestStatus? requestStatus}) {
    return MarkAllAsReadState(
      requestStatus: requestStatus ?? this.requestStatus,
    );
  }

  @override
  List<Object> get props => <Object>[requestStatus];
}
