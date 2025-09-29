import 'dart:async';

import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/features/cart/domain/entities/cart_response.dart';
import 'package:investhub_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:investhub_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateQuantity extends StatefulWidget {
  final CartData cartItem;

  const UpdateQuantity({super.key, required this.cartItem});

  @override
  State<UpdateQuantity> createState() => _UpdateQuantityState();
}

class _UpdateQuantityState extends State<UpdateQuantity> {
  late int _quantity;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _quantity = widget.cartItem.quantity;
  }

  void _changeQuantity(int newQuantity) {
    if (_quantity == 0) return;

    if (newQuantity < 1) {
      _debounce?.cancel();

      setState(() => _quantity = 0);

      context.read<CartCubit>().removeFromCart(
        itemId: widget.cartItem.itemId,
        itemType: widget.cartItem.type,
      );
      return;
    }

    setState(() => _quantity = newQuantity);

    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<CartCubit>().updateCart(
        UpdateCartParams(
          itemId: widget.cartItem.itemId,
          itemType: widget.cartItem.type,
          quantity: _quantity,
        ),
      );
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => _changeQuantity(_quantity + 1),
          child: Container(
            width: 40.sp,
            height: 40.sp,
            decoration: const BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.add, color: AppColors.primary, size: 20.sp),
          ),
        ),
        AppSpacer(widthRatio: 0.6),
        Text(_quantity.toString(), style: TextStyles.medium20),
        AppSpacer(widthRatio: 0.6),
        GestureDetector(
          onTap: () => _changeQuantity(_quantity - 1),
          child: Container(
            width: 40.sp,
            height: 40.sp,
            decoration: BoxDecoration(
              color: _quantity != 1
                  ? AppColors.unActiveBorderColor
                  : AppColors.red.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: _quantity != 1
                ? Icon(Icons.remove, color: AppColors.lightGrey, size: 20.sp)
                : Icon(Icons.delete, color: AppColors.red, size: 20.sp),
          ),
        ),
      ],
    );
  }
}
