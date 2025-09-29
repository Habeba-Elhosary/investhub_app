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
part 'all_tires_state.dart';

class AllTiresCubit extends Cubit<AllTiresState> {
  final AllProductsUsecase allProducts;
  AllTiresCubit({required this.allProducts})
    : super(
        const AllTiresState(
          allRequestStatus: RequestStatus.initial,
          paginationRequestStatus: RequestStatus.initial,
          tires: <Product>[],
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
        loadMoreTires();
      }
    });
  }

  void clearFilter() {
    emit(state.copyWith(searchText: null));
    getTiresForFirstTime();
  }

  Future<void> getTiresForFirstTime() async {
    emit(
      state.copyWith(
        allRequestStatus: RequestStatus.loading,
        tires: <Product>[],
        currentPage: 1,
        lastPage: 1,
      ),
    );

    final Either<Failure, AllProductsResponse> result = await allProducts(
      AllProductsParams(
        page: state.currentPage,
        searchText: state.searchText,
        productType: ProductType.tires,
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
            tires: response.data,
          ),
        );
      },
    );
  }

  Future<void> loadMoreTires() async {
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
        productType: ProductType.tires,
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
            tires: [...state.tires, ...response.data],
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
        getTiresForFirstTime();
      });
    } else {
      getTiresForFirstTime();
    }
  }
}
