import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/enums/item_enum.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/core/widgets/cached_image.dart';
import 'package:investhub_app/core/widgets/shimmer_box.dart';
import 'package:investhub_app/core/widgets/shimmer_loading.dart';
import 'package:investhub_app/features/home/presentation/pages/offer_details_screen.dart';
import 'package:investhub_app/features/home/presentation/pages/product_details_screen.dart';
import 'package:investhub_app/features/orders/data/models/orders_details_response.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailsCardItem extends StatelessWidget {
  final OrderItem item;
  // final bool isOrderDetails;
  const OrderDetailsCardItem({
    super.key,
    required this.item,
    // required this.isOrderDetails,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.type == ItemType.product) {
          appNavigator.push(screen: ProductDetailsScreen(productId: item.id));
        } else {
          appNavigator.push(screen: OfferDetailsScreen(offerId: item.id));
        }
      },
      child: Container(
        padding: EdgeInsets.all(15.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.unActiveBorderColor),
        ),
        child: Row(
          children: [
            CacheNetworkImage(
              fit: BoxFit.scaleDown,
              height: 64.sp,
              width: 64.sp,
              imageUrl: item.image,
            ),
            AppSpacer(widthRatio: 0.5),
            Column(
              spacing: 8.sp,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: TextStyles.bold16),
                Text(
                  "(${LocaleKeys.order_quantity.tr()} : ${item.quantity})",
                  style: TextStyles.regular16.copyWith(
                    color: AppColors.darkPrimary,
                  ),
                ),
              ],
            ),
            // if (isOrderDetails) ...[
            //   Spacer(),
            //   Text(
            //     "${product.price} ${LocaleKeys.pound.tr()}",
            //     style: TextStyles.bold16.copyWith(color: AppColors.primary),
            //   ),
            // ],
          ],
        ),
      ),
    );
  }
}

class OrderDetailsCardShimmerLoading extends StatelessWidget {
  const OrderDetailsCardShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.unActiveBorderColor),
      ),
      child: Row(
        children: [
          ShimmerLoading(
            widget: ShimmerBox(height: 64, width: 64, borderRadius: 4.r),
          ),

          AppSpacer(widthRatio: 0.5),
          Column(
            spacing: 8.sp,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerLoading(
                widget: ShimmerBox(height: 16, width: 120, borderRadius: 4.r),
              ),

              ShimmerLoading(
                widget: ShimmerBox(height: 16, width: 100, borderRadius: 4.r),
              ),
            ],
          ),
          Spacer(),
          ShimmerLoading(
            widget: ShimmerBox(height: 16, width: 80, borderRadius: 4.r),
          ),
        ],
      ),
    );
  }
}
