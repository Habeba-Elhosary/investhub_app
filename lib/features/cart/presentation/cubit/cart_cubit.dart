import 'dart:async';
import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/entities/status_response.dart';
import 'package:investhub_app/core/enums/item_enum.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/core/util/request_status.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/core/widgets/show_no_context_dialog.dart';
import 'package:investhub_app/core/widgets/toast.dart';
import 'package:investhub_app/features/cart/domain/entities/cart_response.dart';
import 'package:investhub_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:investhub_app/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:investhub_app/features/cart/domain/usecases/remove_cart_usecase.dart';
import 'package:investhub_app/features/cart/domain/usecases/show_cart_usecase.dart';
import 'package:investhub_app/features/cart/domain/usecases/update_cart_usecase.dart';
import 'package:investhub_app/features/cart/presentation/pages/cart_screen.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final ShowCartUsecase showCartUsecase;
  final AddToCartUsecase addToCartUsecase;
  final UpdateCartUsecase updateCartUsecase;
  final RemoveCartUsecase removeCartUsecase;

  CartCubit({
    required this.showCartUsecase,
    required this.addToCartUsecase,
    required this.updateCartUsecase,
    required this.removeCartUsecase,
  }) : super(CartState());

  Future<void> showCart() async {
    emit(state.copyWith(requestStatus: RequestStatus.loading));
    final result = await showCartUsecase(NoParams());
    result.fold(
      (Failure failure) => emit(
        state.copyWith(
          requestStatus: RequestStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (CartResponse response) => emit(
        state.copyWith(
          requestStatus: RequestStatus.success,
          items: response.data,
          // totalItems: response.total,
        ),
      ),
    );
  }

  Future<void> addToCart({
    required int itemId,
    required ItemType itemType,
  }) async {
    emit(state.copyWith(requestStatus: RequestStatus.loading));
    final result = await addToCartUsecase(
      CartParams(itemId: itemId, itemType: itemType),
    );
    result.fold(
      (Failure failure) {
        emit(state.copyWith(requestStatus: RequestStatus.error));
        if (failure is ProductAlreadyExistInCartFailure) {
          showNoContextDialog(
            navigator: appNavigator,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.sp, vertical: 30.sp),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Image.asset(AppAssets.imagesCartBlock, height: 150.sp),
                  const AppSpacer(heightRatio: 1),
                  Text(
                    failure.message,
                    textAlign: TextAlign.center,
                    style: TextStyles.bold18.copyWith(color: AppColors.red),
                  ),
                  const AppSpacer(heightRatio: 1),
                  ElevatedButton(
                    onPressed: () {
                      appNavigator.pop();
                      appNavigator.push(screen: CartScreen());
                    },
                    child: Text(LocaleKeys.go_to_cart.tr()),
                  ),
                ],
              ),
            ),
          );
        } else {
          showErrorToast(failure.message);
        }
      },
      (StatusResponse response) {
        emit(state.copyWith(requestStatus: RequestStatus.success));
        showSucessToast(response.message);
      },
    );
  }

  Future<void> updateCart(UpdateCartParams params) async {
    final result = await updateCartUsecase(params);
    result.fold(
      (Failure failure) {
        showErrorToast(failure.message);
      },
      (StatusResponse response) {
        showSucessToast(response.message);
        showCart();
      },
    );
  }

  Future<void> removeFromCart({
    required int itemId,
    required ItemType itemType,
  }) async {
    final result = await removeCartUsecase(
      CartParams(itemId: itemId, itemType: itemType),
    );
    result.fold(
      (Failure failure) {
        showErrorToast(failure.message);
      },
      (StatusResponse response) {
        showSucessToast(response.message);
        showCart();
      },
    );
  }
}
