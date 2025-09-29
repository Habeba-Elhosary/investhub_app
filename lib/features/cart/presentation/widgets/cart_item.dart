import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/core/widgets/cached_image.dart';
import 'package:investhub_app/core/widgets/shimmer_box.dart';
import 'package:investhub_app/core/widgets/shimmer_loading.dart';
import 'package:investhub_app/features/cart/domain/entities/cart_response.dart';
import 'package:investhub_app/features/cart/presentation/widgets/update_quantity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItem extends StatelessWidget {
  final CartData cartItem;

  const CartItem({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.unActiveBorderColor),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Row(
          children: [
            CacheNetworkImage(
              fit: BoxFit.contain,
              height: 85.sp,
              width: 85.sp,
              imageUrl: cartItem.image,
            ),
            AppSpacer(widthRatio: 0.7),
            Expanded(
              child: Column(
                spacing: 8.sp,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cartItem.title, style: TextStyles.regular18),
                  // if (cartItem.product.priceAfterDiscount != null) ...[
                  //   Row(
                  //     children: [
                  //       Text(
                  //         '${cartItem.product.priceAfterDiscount} ${LocaleKeys.pound.tr()}',
                  //         style: TextStyles.bold16,
                  //       ),
                  //       AppSpacer(widthRatio: 0.5),
                  //       Expanded(
                  //         child: Text(
                  //           '${cartItem.product.price} ${LocaleKeys.pound.tr()}',
                  //           style: TextStyles.regular16.copyWith(
                  //             color: AppColors.greyHint,
                  //             decoration: TextDecoration.lineThrough,
                  //             decorationThickness: 30.sp,
                  //           ),
                  //           overflow: TextOverflow.ellipsis,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ] else ...[
                  //   Text(
                  //     '${cartItem.product.price} ${LocaleKeys.pound.tr()}',
                  //     style: TextStyles.bold16,
                  //   ),
                  // ],
                ],
              ),
            ),
            UpdateQuantity(cartItem: cartItem),
          ],
        ),
      ),
    );
  }
}

class CartItemShimmer extends StatelessWidget {
  const CartItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.unActiveBorderColor),
      ),
      padding: EdgeInsets.all(12.sp),
      child: Row(
        children: [
          ShimmerLoading(
            widget: ShimmerBox(height: 90.sp, width: 90.sp, borderRadius: 5.r),
          ),
          AppSpacer(widthRatio: 0.5),
          Expanded(
            child: Column(
              spacing: 8.sp,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerLoading(
                  widget: ShimmerBox(
                    height: 20.sp,
                    width: 200.sp,
                    borderRadius: 5.r,
                  ),
                ),
                ShimmerLoading(
                  widget: ShimmerBox(
                    height: 20.sp,
                    width: 100.sp,
                    borderRadius: 5.r,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ShimmerLoading(
                widget: ShimmerBox(
                  height: 40.sp,
                  width: 40.sp,
                  shape: BoxShape.circle,
                ),
              ),
              AppSpacer(widthRatio: 0.6),
              ShimmerLoading(
                widget: ShimmerBox(
                  height: 30.sp,
                  width: 20.sp,
                  borderRadius: 5.r,
                ),
              ),
              AppSpacer(widthRatio: 0.6),
              ShimmerLoading(
                widget: ShimmerBox(
                  height: 40.sp,
                  width: 40.sp,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
