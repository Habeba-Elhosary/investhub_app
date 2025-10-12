import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/widgets/toast.dart';
import 'package:investhub_app/features/home/domain/entities/opportunity.dart';
import 'package:investhub_app/features/home/domain/usecases/get_opportunities_usecase.dart';

part 'opportunities_state.dart';

class OpportunitiesCubit extends Cubit<OpportunitiesState> {
  final GetOpportunitiesUsecase getOpportunitiesUsecase;
  static const _pageSize = 10;

  OpportunitiesCubit({required this.getOpportunitiesUsecase})
    : super(OpportunitiesInitial()){
      getOpportunitiesEvent();
    }

  final PagingController<int, Opportunity> pagingController = PagingController(
    firstPageKey: 1,
  );

  Future<void> getOpportunitiesEvent() async {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final Either<Failure, OpportunitiesResponse> result =
          await getOpportunitiesUsecase(pageKey);
      result.fold(
        (Failure fail) {
          showErrorToast(fail.message);
          pagingController.error = fail.message;
        },
        (OpportunitiesResponse response) {
          final isLastPage = response.data.length == 0;
          if (isLastPage) {
            pagingController.appendLastPage(response.data);
          } else {
            final nextPageKey = pageKey + 1;
            pagingController.appendPage(response.data, nextPageKey);
          }
        },
      );
    } catch (error) {
      pagingController.error = error;
    }
  }

  void refresh() {
    pagingController.refresh();
  }
}
