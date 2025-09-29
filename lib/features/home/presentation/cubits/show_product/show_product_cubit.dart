import 'package:investhub_app/features/home/data/models/all_products_response.dart';
import 'package:investhub_app/features/home/domain/usecases/show_product_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'show_product_state.dart';

class ShowProductCubit extends Cubit<ShowProductState> {
  final ShowProductUsecase showProductUsecase;
  ShowProductCubit({required this.showProductUsecase})
    : super(ShowProductInitial());

  Future<void> showProductEvent({required int productId}) async {
    emit(ShowProductLoading());
    final result = await showProductUsecase(productId);
    result.fold(
      (failure) => emit(ShowProductError(message: failure.message)),
      (product) => emit(ShowProductLoaded(product: product)),
    );
  }
}
