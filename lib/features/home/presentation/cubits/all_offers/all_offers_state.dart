part of 'all_offers_cubit.dart';

class AllOffersState extends Equatable {
  final RequestStatus allRequestStatus;
  final RequestStatus paginationRequestStatus;
  final List<OfferSummary> offers;
  final String generalErrorMessage;
  final String paginationErrorMessage;
  final String? searchText;
  final int currentPage;
  final int lastPage;

  const AllOffersState({
    this.searchText,
    this.allRequestStatus = RequestStatus.initial,
    this.paginationRequestStatus = RequestStatus.initial,
    this.offers = const <OfferSummary>[],
    this.generalErrorMessage = '',
    this.paginationErrorMessage = '',
    this.currentPage = 1,
    this.lastPage = 1,
  });

  @override
  List<Object?> get props => <Object?>[
    allRequestStatus,
    paginationRequestStatus,
    List<OfferSummary>.from(offers),
    generalErrorMessage,
    paginationErrorMessage,
    searchText,
    currentPage,
    lastPage,
  ];

  AllOffersState copyWith({
    RequestStatus? allRequestStatus,
    RequestStatus? paginationRequestStatus,
    List<OfferSummary>? offers,
    String? generalErrorMessage,
    String? paginationErrorMessage,
    int? currentPage,
    int? lastPage,
    String? searchText,
  }) {
    return AllOffersState(
      searchText: searchText ?? this.searchText,
      allRequestStatus: allRequestStatus ?? this.allRequestStatus,
      paginationRequestStatus:
          paginationRequestStatus ?? this.paginationRequestStatus,
      offers: offers ?? this.offers,
      paginationErrorMessage:
          paginationErrorMessage ?? this.paginationErrorMessage,
      generalErrorMessage: generalErrorMessage ?? this.generalErrorMessage,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
    );
  }
}
