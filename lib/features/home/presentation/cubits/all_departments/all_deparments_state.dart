part of 'all_deparments_cubit.dart';

class AllDeparmentsState extends Equatable {
  final RequestStatus allRequestStatus;
  final RequestStatus paginationRequestStatus;
  final List<Department> departments;
  final String generalErrorMessage;
  final String paginationErrorMessage;
  final String? searchText;
  final int currentPage;
  final int lastPage;
  const AllDeparmentsState({
    this.searchText,
    this.allRequestStatus = RequestStatus.initial,
    this.paginationRequestStatus = RequestStatus.initial,
    this.departments = const <Department>[],
    this.generalErrorMessage = '',
    this.paginationErrorMessage = '',
    this.currentPage = 1,
    this.lastPage = 1,
  });

  @override
  List<Object?> get props => <Object?>[
    allRequestStatus,
    paginationRequestStatus,
    List<Department>.from(departments),
    generalErrorMessage,
    paginationErrorMessage,
    searchText,
    currentPage,
    lastPage,
  ];

  AllDeparmentsState copyWith({
    RequestStatus? allRequestStatus,
    RequestStatus? paginationRequestStatus,
    List<Department>? departments,
    String? generalErrorMessage,
    String? paginationErrorMessage,
    int? currentPage,
    int? lastPage,
    String? searchText,
  }) {
    return AllDeparmentsState(
      searchText: searchText ?? this.searchText,
      allRequestStatus: allRequestStatus ?? this.allRequestStatus,
      paginationRequestStatus:
          paginationRequestStatus ?? this.paginationRequestStatus,
      departments: departments ?? this.departments,
      paginationErrorMessage:
          paginationErrorMessage ?? this.paginationErrorMessage,
      generalErrorMessage: generalErrorMessage ?? this.generalErrorMessage,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
    );
  }
}
