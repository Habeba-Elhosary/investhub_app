part of 'all_tires_cubit.dart';

class AllTiresState extends Equatable {
  final RequestStatus allRequestStatus;
  final RequestStatus paginationRequestStatus;
  final List<Product> tires;
  final String generalErrorMessage;
  final String paginationErrorMessage;
  final String? searchText;
  final int currentPage;
  final int lastPage;

  const AllTiresState({
    this.searchText,
    this.allRequestStatus = RequestStatus.initial,
    this.paginationRequestStatus = RequestStatus.initial,
    this.tires = const <Product>[],
    this.generalErrorMessage = '',
    this.paginationErrorMessage = '',
    this.currentPage = 1,
    this.lastPage = 1,
  });

  @override
  List<Object?> get props => <Object?>[
    allRequestStatus,
    paginationRequestStatus,
    List<Product>.from(tires),
    generalErrorMessage,
    paginationErrorMessage,
    searchText,
    currentPage,
    lastPage,
  ];

  AllTiresState copyWith({
    RequestStatus? allRequestStatus,
    RequestStatus? paginationRequestStatus,
    List<Product>? tires,
    String? generalErrorMessage,
    String? paginationErrorMessage,
    int? currentPage,
    int? lastPage,
    String? searchText,
  }) {
    return AllTiresState(
      searchText: searchText ?? this.searchText,
      allRequestStatus: allRequestStatus ?? this.allRequestStatus,
      paginationRequestStatus:
          paginationRequestStatus ?? this.paginationRequestStatus,
      tires: tires ?? this.tires,
      paginationErrorMessage:
          paginationErrorMessage ?? this.paginationErrorMessage,
      generalErrorMessage: generalErrorMessage ?? this.generalErrorMessage,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
    );
  }
}
