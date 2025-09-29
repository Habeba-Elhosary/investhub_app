part of 'show_offer_cubit.dart';

sealed class ShowOfferState extends Equatable {
  const ShowOfferState();

  @override
  List<Object> get props => [];
}

final class ShowOfferInitial extends ShowOfferState {}

final class ShowOfferLoading extends ShowOfferState {}

final class ShowOfferLoaded extends ShowOfferState {
  final Offer offer;
  const ShowOfferLoaded({required this.offer});
}

final class ShowOfferError extends ShowOfferState {
  final String message;
  const ShowOfferError({required this.message});
}
