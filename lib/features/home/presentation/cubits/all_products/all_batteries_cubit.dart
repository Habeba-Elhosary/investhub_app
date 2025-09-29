import 'dart:async';
import 'package:investhub_app/core/enums/product_enum.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/util/request_status.dart';
import 'package:investhub_app/features/home/data/models/all_products_response.dart';
import 'package:investhub_app/features/home/domain/repositories/home_repository.dart';
import 'package:investhub_app/features/home/domain/usecases/all_products_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'all_batteries_state.dart';

class AllBatteriesCubit extends Cubit<AllBatteriesState> {
  final AllProductsUsecase allProducts;
  AllBatteriesCubit({required this.allProducts})
    : super(
        const AllBatteriesState(
          allRequestStatus: RequestStatus.initial,
          paginationRequestStatus: RequestStatus.initial,
          batteries: <Product>[],
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
        loadMoreBatteries();
      }
    });
  }

  void clearFilter() {
    emit(state.copyWith(searchText: null));
    getBatteriesForFirstTime();
  }

  Future<void> getBatteriesForFirstTime() async {
    emit(
      state.copyWith(
        allRequestStatus: RequestStatus.loading,
        batteries: <Product>[],
        currentPage: 1,
        lastPage: 1,
      ),
    );

    final Either<Failure, AllProductsResponse> result = await allProducts(
      AllProductsParams(
        page: state.currentPage,
        searchText: state.searchText,
        productType: ProductType.batteries,
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
            batteries: response.data,
          ),
        );
      },
    );
  }

  Future<void> loadMoreBatteries() async {
    if (state.currentPage >= state.lastPage) {
      return;
    }
    emit(
      state.copyWith(
        currentPage: state.currentPage + 1,
        paginationRequestStatus: RequestStatus.loading,
      ),
    );
    final Either<Failure, AllProductsResponse> result = await allProducts(
      AllProductsParams(
        page: state.currentPage,
        searchText: state.searchText,
        productType: ProductType.batteries,
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
            batteries: List.from(state.batteries + response.data),
          ),
        );
      },
    );
  }

  void setFilter({String? searchText, ProductType? productType}) {
    emit(state.copyWith(searchText: searchText, currentPage: 1));

    if (searchText != null && searchText.isNotEmpty) {
      if (_debounce?.isActive ?? false) {
        _debounce?.cancel();
      }
      _debounce = Timer(const Duration(milliseconds: 500), () {
        getBatteriesForFirstTime();
      });
    } else {
      getBatteriesForFirstTime();
    }
  }
}
