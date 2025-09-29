import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/core/widgets/cached_image.dart';
import 'package:investhub_app/core/widgets/shimmer_loading.dart';
import 'package:investhub_app/features/home/data/models/all_products_response.dart';
import 'package:investhub_app/features/home/presentation/pages/product_details_screen.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCardItem extends StatefulWidget {
  final Product product;

  const ProductCardItem({super.key, required this.product});

  @override
  State<ProductCardItem> createState() => _ProductCardItemState();
}

class _ProductCardItemState extends State<ProductCardItem> {
  @override
  Widget build(BuildContext context) {
    // final bool isLoggedIn = TokenStorageHelper.isLoggedIn;

    return GestureDetector(
      onTap: () {
        appNavigator.push(
          screen: ProductDetailsScreen(productId: widget.product.id),
        );
      },
      child: Container(
        width: 180.sp,
        padding: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.unActiveBorderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: CacheNetworkImage(
                fit: BoxFit.fitWidth,
                imageUrl: widget.product.image,
              ),
            ),
            AppSpacer(heightRatio: 0.5),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${LocaleKeys.brand.tr()} : ${widget.product.brand}',
                    style: TextStyles.regular14.copyWith(
                      color: AppColors.greyHint,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    widget.product.name,
                    style: TextStyles.regular16,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  // if (isLoggedIn) ...[
                  //   if (widget.product.priceAfterDiscount != null) ...[
                  //     Row(
                  //       children: [
                  //         Text(
                  //           '${widget.product.priceAfterDiscount} ${LocaleKeys.pound.tr()}',
                  //           style: TextStyles.bold16,
                  //         ),
                  //         AppSpacer(widthRatio: 0.5),
                  //         Text(
                  //           '${widget.product.price} ${LocaleKeys.pound.tr()}',
                  //           style: TextStyles.regular12.copyWith(
                  //             color: AppColors.greyHint,
                  //             decoration: TextDecoration.lineThrough,
                  //             decorationThickness: 30.sp,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ] else ...[
                  //     Text(
                  //       '${widget.product.price} ${LocaleKeys.pound.tr()}',
                  //       style: TextStyles.bold16,
                  //     ),
                  //   ],
                  //   ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.sp,
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.unActiveBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: ShimmerLoading(
              widget: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
            ),
          ),
          AppSpacer(heightRatio: 0.5),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                ShimmerLoading(
                  widget: Container(
                    width: 80.sp,
                    height: 15.sp,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                ShimmerLoading(
                  widget: Container(
                    width: 120.sp,
                    height: 15.sp,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                // Row(
                //   children: [
                //     ShimmerLoading(
                //       widget: Container(
                //         width: 70.sp,
                //         height: 15.sp,
                //         decoration: BoxDecoration(
                //           color: Colors.white,
                //           borderRadius: BorderRadius.circular(2.r),
                //         ),
                //       ),
                //     ),
                //     AppSpacer(widthRatio: 0.5),
                //     ShimmerLoading(
                //       widget: Container(
                //         width: 70.sp,
                //         height: 15.sp,
                //         decoration: BoxDecoration(
                //           color: Colors.white,
                //           borderRadius: BorderRadius.circular(2.r),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
