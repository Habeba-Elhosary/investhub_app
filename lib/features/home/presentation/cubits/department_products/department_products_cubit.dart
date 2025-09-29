import 'dart:async';

import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/util/request_status.dart';
import 'package:investhub_app/features/home/data/models/all_products_response.dart';
import 'package:investhub_app/features/home/domain/repositories/home_repository.dart';
import 'package:investhub_app/features/home/domain/usecases/get_department_products_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'department_products_state.dart';

class DepartmentProductsCubit extends Cubit<DepartmentProductsState> {
  final GetDepartmentProductsUsecase getDepartmentProducts;
  DepartmentProductsCubit({required this.getDepartmentProducts})
    : super(
        const DepartmentProductsState(
          allRequestStatus: RequestStatus.initial,
          paginationRequestStatus: RequestStatus.initial,
          products: <Product>[],
          currentPage: 1,
          lastPage: 1,
        ),
      );

  Timer? _debounce;
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  void initScoll() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        loadMoreProducts();
      }
    });
  }

  void clearFilter() {
    emit(state.copyWith(searchText: null, departmentId: null));
    getDepartmentProductsForFirstTime();
  }

  Future<void> getDepartmentProductsForFirstTime() async {
    if (state.departmentId == null) {
      return;
    }

    emit(
      state.copyWith(
        allRequestStatus: RequestStatus.loading,
        products: <Product>[],
        currentPage: 1,
        lastPage: 1,
      ),
    );

    final Either<Failure, AllProductsResponse> result =
        await getDepartmentProducts(
          DepartmentProductsParams(
            page: state.currentPage,
            searchText: state.searchText,
            departmentId: state.departmentId!,
          ),
        );
    result.fold(
      (Failure failure) => emit(
        state.copyWith(
          allRequestStatus: RequestStatus.error,
          generalErrorMessage: failure.message,
        ),
      ),
      (AllProductsResponse response) {
        emit(
          state.copyWith(
            allRequestStatus: RequestStatus.success,
            lastPage: response.meta.lastPage,
            products: response.data,
          ),
        );
      },
    );
  }

  Future<void> loadMoreProducts() async {
    if ((state.currentPage >= state.lastPage) || (state.departmentId == null)) {
      return;
    }

    emit(
      state.copyWith(
        currentPage: state.currentPage + 1,
        paginationRequestStatus: RequestStatus.loading,
      ),
    );
    final Either<Failure, AllProductsResponse> result =
        await getDepartmentProducts(
          DepartmentProductsParams(
            page: state.currentPage,
            searchText: state.searchText,
            departmentId: state.departmentId!,
          ),
        );
    result.fold(
      (Failure failure) => emit(
        state.copyWith(
          currentPage: state.currentPage - 1,
          paginationRequestStatus: RequestStatus.error,
          paginationErrorMessage: failure.message,
        ),
      ),
      (AllProductsResponse response) {
        emit(
          state.copyWith(
            paginationRequestStatus: RequestStatus.success,
            lastPage: response.meta.lastPage,
            products: List.from(state.products + response.data),
          ),
        );
      },
    );
  }

  void setFilter({String? searchText, int? departmentId}) {
    emit(
      state.copyWith(
        searchText: searchText,
        currentPage: 1,
        departmentId: departmentId,
      ),
    );
    if (searchText != null && searchText.isNotEmpty) {
      if (_debounce?.isActive ?? false) {
        _debounce?.cancel();
      }
      _debounce = Timer(const Duration(milliseconds: 500), () {
        getDepartmentProductsForFirstTime();
      });
    } else {
      getDepartmentProductsForFirstTime();
    }
  }
}
