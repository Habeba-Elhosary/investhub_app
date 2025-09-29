part of 'all_batteries_cubit.dart';

class AllBatteriesState extends Equatable {
  final RequestStatus allRequestStatus;
  final RequestStatus paginationRequestStatus;
  final List<Product> batteries;
  final String generalErrorMessage;
  final String paginationErrorMessage;
  final String? searchText;
  final int currentPage;
  final int lastPage;

  const AllBatteriesState({
    this.searchText,
    this.allRequestStatus = RequestStatus.initial,
    this.paginationRequestStatus = RequestStatus.initial,
    this.batteries = const <Product>[],
    this.generalErrorMessage = '',
    this.paginationErrorMessage = '',
    this.currentPage = 1,
    this.lastPage = 1,
  });

  @override
  List<Object?> get props => <Object?>[
    allRequestStatus,
    paginationRequestStatus,
    List<Product>.from(batteries),
    generalErrorMessage,
    paginationErrorMessage,
    searchText,
    currentPage,
    lastPage,
  ];

  AllBatteriesState copyWith({
    RequestStatus? allRequestStatus,
    RequestStatus? paginationRequestStatus,
    List<Product>? batteries,
    String? generalErrorMessage,
    String? paginationErrorMessage,
    int? currentPage,
    int? lastPage,
    String? searchText,
  }) {
    return AllBatteriesState(
      searchText: searchText ?? this.searchText,
      allRequestStatus: allRequestStatus ?? this.allRequestStatus,
      paginationRequestStatus:
          paginationRequestStatus ?? this.paginationRequestStatus,
      batteries: batteries ?? this.batteries,
      paginationErrorMessage:
          paginationErrorMessage ?? this.paginationErrorMessage,
      generalErrorMessage: generalErrorMessage ?? this.generalErrorMessage,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
    );
  }
}
