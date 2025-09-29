import 'dart:async';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/util/request_status.dart';
import 'package:investhub_app/features/home/data/models/all_offers_response.dart';
import 'package:investhub_app/features/home/domain/repositories/home_repository.dart';
import 'package:investhub_app/features/home/domain/usecases/all_offers_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'all_offers_state.dart';

class AllOffersCubit extends Cubit<AllOffersState> {
  final AllOffersUsecase allOffersUsecase;
  AllOffersCubit({required this.allOffersUsecase})
    : super(
        const AllOffersState(
          allRequestStatus: RequestStatus.initial,
          paginationRequestStatus: RequestStatus.initial,
          offers: <OfferSummary>[],
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
        loadMoreOffers();
      }
    });
  }

  void clearFilter() {
    emit(state.copyWith(searchText: null));
    getOffersForFirstTime();
  }

  Future<void> getOffersForFirstTime() async {
    emit(
      state.copyWith(
        allRequestStatus: RequestStatus.loading,
        offers: <OfferSummary>[],
        currentPage: 1,
        lastPage: 1,
      ),
    );

    final Either<Failure, AllOffersResponse> result = await allOffersUsecase(
      PaginationParams(page: state.currentPage, searchText: state.searchText),
    );
    result.fold(
      (Failure failure) => emit(
        state.copyWith(
          allRequestStatus: RequestStatus.error,
          generalErrorMessage: failure.message,
        ),
      ),
      (AllOffersResponse response) => emit(
        state.copyWith(
          allRequestStatus: RequestStatus.success,
          lastPage: response.meta.lastPage,
          offers: response.data,
        ),
      ),
    );
  }

  Future<void> loadMoreOffers() async {
    if (state.currentPage >= state.lastPage) {
      return;
    }
    emit(
      state.copyWith(
        currentPage: state.currentPage + 1,
        paginationRequestStatus: RequestStatus.loading,
      ),
    );
    final Either<Failure, AllOffersResponse> result = await allOffersUsecase(
      PaginationParams(page: state.currentPage, searchText: state.searchText),
    );
    result.fold(
      (Failure failure) => emit(
        state.copyWith(
          currentPage: state.currentPage - 1,
          paginationRequestStatus: RequestStatus.error,
          paginationErrorMessage: failure.message,
        ),
      ),
      (AllOffersResponse response) => emit(
        state.copyWith(
          paginationRequestStatus: RequestStatus.success,
          offers: List.from(state.offers + response.data),
          currentPage: state.currentPage,
        ),
      ),
    );
  }

  void setFilter({String? searchText}) {
    emit(state.copyWith(searchText: searchText, currentPage: 1));

    if (searchText != null && searchText.isNotEmpty) {
      if (_debounce?.isActive ?? false) {
        _debounce?.cancel();
      }
      _debounce = Timer(const Duration(milliseconds: 500), () {
        getOffersForFirstTime();
      });
    } else {
      getOffersForFirstTime();
    }
  }
}
