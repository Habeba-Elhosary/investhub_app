import 'dart:async';

import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/util/request_status.dart';
import 'package:investhub_app/features/home/data/models/all_departments_response.dart';
import 'package:investhub_app/features/home/domain/repositories/home_repository.dart';
import 'package:investhub_app/features/home/domain/usecases/all_departments_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'all_deparments_state.dart';

class AllDeparmentsCubit extends Cubit<AllDeparmentsState> {
  final AllDepartmentsUsecase allDepartments;
  AllDeparmentsCubit({required this.allDepartments})
    : super(
        const AllDeparmentsState(
          allRequestStatus: RequestStatus.initial,
          paginationRequestStatus: RequestStatus.initial,
          departments: <Department>[],
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
        loadMoreDepartments();
      }
    });
  }

  void clearFilter() {
    emit(state.copyWith(searchText: null));
    getDepartmentsForFirstTime();
  }

  Future<void> getDepartmentsForFirstTime() async {
    emit(
      state.copyWith(
        allRequestStatus: RequestStatus.loading,
        departments: <Department>[],
        currentPage: 1,
        lastPage: 1,
      ),
    );

    final Either<Failure, AllDepartmentsResponse> result = await allDepartments(
      PaginationParams(page: state.currentPage, searchText: state.searchText),
    );
    result.fold(
      (Failure failure) => emit(
        state.copyWith(
          allRequestStatus: RequestStatus.error,
          generalErrorMessage: failure.message,
        ),
      ),
      (AllDepartmentsResponse response) => emit(
        state.copyWith(
          allRequestStatus: RequestStatus.success,
          lastPage: response.meta.lastPage,
          departments: response.data,
        ),
      ),
    );
  }

  Future<void> loadMoreDepartments() async {
    if (state.currentPage >= state.lastPage) {
      return;
    }
    emit(
      state.copyWith(
        currentPage: state.currentPage + 1,
        paginationRequestStatus: RequestStatus.loading,
      ),
    );
    final Either<Failure, AllDepartmentsResponse> result = await allDepartments(
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
      (AllDepartmentsResponse response) => emit(
        state.copyWith(
          paginationRequestStatus: RequestStatus.success,
          departments: List.from(state.departments + response.data),
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
        getDepartmentsForFirstTime();
      });
    } else {
      getDepartmentsForFirstTime();
    }
  }
}
