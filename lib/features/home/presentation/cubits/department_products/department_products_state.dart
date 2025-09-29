part of 'department_products_cubit.dart';

class DepartmentProductsState extends Equatable {
  final RequestStatus allRequestStatus;
  final RequestStatus paginationRequestStatus;
  final List<Product> products;
  final String generalErrorMessage;
  final String paginationErrorMessage;
  final String? searchText;
  final int currentPage;
  final int lastPage;
  final int? departmentId;

  const DepartmentProductsState({
    this.searchText,
    this.allRequestStatus = RequestStatus.initial,
    this.paginationRequestStatus = RequestStatus.initial,
    this.products = const <Product>[],
    this.generalErrorMessage = '',
    this.paginationErrorMessage = '',
    this.currentPage = 1,
    this.lastPage = 1,
    this.departmentId,
  });

  @override
  List<Object?> get props => <Object?>[
    allRequestStatus,
    paginationRequestStatus,
    List<Product>.from(products),
    generalErrorMessage,
    paginationErrorMessage,
    searchText,
    currentPage,
    lastPage,
    departmentId,
  ];

  DepartmentProductsState copyWith({
    RequestStatus? allRequestStatus,
    RequestStatus? paginationRequestStatus,
    List<Product>? products,
    String? generalErrorMessage,
    String? paginationErrorMessage,
    int? currentPage,
    int? lastPage,
    String? searchText,
    int? departmentId,
  }) {
    return DepartmentProductsState(
      searchText: searchText ?? this.searchText,
      allRequestStatus: allRequestStatus ?? this.allRequestStatus,
      paginationRequestStatus:
          paginationRequestStatus ?? this.paginationRequestStatus,
      products: products ?? this.products,
      paginationErrorMessage:
          paginationErrorMessage ?? this.paginationErrorMessage,
      generalErrorMessage: generalErrorMessage ?? this.generalErrorMessage,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      departmentId: departmentId ?? this.departmentId,
    );
  }
}
