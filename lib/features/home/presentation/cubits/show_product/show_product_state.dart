part of 'show_product_cubit.dart';

sealed class ShowProductState extends Equatable {
  const ShowProductState();

  @override
  List<Object> get props => [];
}

final class ShowProductInitial extends ShowProductState {}

final class ShowProductLoading extends ShowProductState {}

final class ShowProductLoaded extends ShowProductState {
  final Product product;
  const ShowProductLoaded({required this.product});
}

final class ShowProductError extends ShowProductState {
  final String message;
  const ShowProductError({required this.message});
}
