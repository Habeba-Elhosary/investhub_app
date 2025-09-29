import 'package:investhub_app/features/home/data/models/all_offers_response.dart';
import 'package:investhub_app/features/home/domain/usecases/show_offer_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'show_offer_state.dart';

class ShowOfferCubit extends Cubit<ShowOfferState> {
  final ShowOfferUsecase showOfferUsecase;
  ShowOfferCubit({required this.showOfferUsecase}) : super(ShowOfferInitial());

  Future<void> showOfferEvent({required int offerId}) async {
    emit(ShowOfferLoading());
    final result = await showOfferUsecase(offerId);
    result.fold(
      (failure) => emit(ShowOfferError(message: failure.message)),
      (offer) => emit(ShowOfferLoaded(offer: offer)),
    );
  }
}
