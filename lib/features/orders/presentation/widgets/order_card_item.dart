import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/enums/order_type_enum.dart';
import 'package:investhub_app/core/util/helper.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/core/widgets/shimmer_box.dart';
import 'package:investhub_app/core/widgets/shimmer_loading.dart';
import 'package:investhub_app/features/orders/data/models/orders_response.dart';
import 'package:investhub_app/features/orders/presentation/pages/order_details_screen.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderCardItem extends StatelessWidget {
  final OrderData orderData;
  final OrderType orderType;
  const OrderCardItem({
    super.key,
    required this.orderData,
    required this.orderType,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          appNavigator.push(screen: OrderDetailsScreen(orderId: orderData.id)),
      child: Container(
        padding: EdgeInsets.all(15.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.unActiveBorderColor),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${LocaleKeys.order_order_number.tr()} : ${orderData.serialNumber}",
                  style: TextStyles.bold16,
                ),
                AppSpacer(heightRatio: 0.5),
                // Row(
                //   children: [
                //     Text(
                //       LocaleKeys.order_total.tr(),
                //       style: TextStyles.bold16.copyWith(
                //         color: AppColors.darkPrimary,
                //       ),
                //     ),
                //     Text(
                //       '${orderData.total} ${LocaleKeys.pound.tr()}',
                //       style: TextStyles.bold16.copyWith(color: orderType.color),
                //     ),
                //   ],
                // ),
                AppSpacer(heightRatio: 0.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      spacing: 5.sp,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.imagesCalendar,
                          fit: BoxFit.scaleDown,
                        ),
                        Text(
                          DateTimeHelper.formatDate(orderData.createdAt),
                          style: TextStyles.regular16.copyWith(
                            color: AppColors.greyHint,
                          ),
                        ),
                      ],
                    ),
                    AppSpacer(widthRatio: 1),
                    Row(
                      spacing: 5.sp,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.imagesClock,
                          fit: BoxFit.scaleDown,
                        ),
                        Text(
                          DateTimeHelper.formatTime(orderData.createdAt),
                          style: TextStyles.regular16.copyWith(
                            color: AppColors.greyHint,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            CircleAvatar(
              backgroundColor: orderType.color,
              foregroundColor: AppColors.white,
              radius: 20.r,
              child: Icon(Icons.arrow_forward_rounded, size: 25.sp),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderCardItemShimmer extends StatelessWidget {
  const OrderCardItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.sp),
      padding: EdgeInsets.all(14.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.unActiveBorderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerLoading(
                widget: ShimmerBox(
                  height: 20.sp,
                  width: 120.sp,
                  borderRadius: 2.r,
                ),
              ),
              AppSpacer(heightRatio: 0.7),
              // ShimmerLoading(
              //   widget: ShimmerBox(
              //     height: 20.sp,
              //     width: 170.sp,
              //     borderRadius: 4.r,
              //   ),
              // ),
              // AppSpacer(heightRatio: 0.7),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 8.sp,
                    children: [
                      Row(
                        spacing: 4.sp,
                        children: [
                          ShimmerLoading(
                            widget: ShimmerBox(
                              height: 25.sp,
                              width: 25.sp,
                              shape: BoxShape.circle,
                            ),
                          ),
                          ShimmerLoading(
                            widget: ShimmerBox(
                              height: 20.sp,
                              width: 80,
                              borderRadius: 2.r,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        spacing: 4.sp,
                        children: [
                          ShimmerLoading(
                            widget: ShimmerBox(
                              height: 25.sp,
                              width: 25.sp,
                              shape: BoxShape.circle,
                            ),
                          ),
                          ShimmerLoading(
                            widget: ShimmerBox(
                              height: 20.sp,
                              width: 80,
                              borderRadius: 2.r,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          ShimmerLoading(
            widget: ShimmerBox(
              height: 50.sp,
              width: 50.sp,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
