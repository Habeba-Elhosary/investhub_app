import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/enums/notification_type_enum.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/core/widgets/shimmer_box.dart';
import 'package:investhub_app/core/widgets/shimmer_loading.dart';
import 'package:investhub_app/features/home/presentation/pages/offer_details_screen.dart';
import 'package:investhub_app/features/notifications/domain/entities/notification_response.dart';
import 'package:investhub_app/features/orders/presentation/pages/order_details_screen.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class NotificationCard extends StatelessWidget {
  final NotificationEntity notification;

  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (notification.data.notificationType == NotificationType.order) {
          appNavigator.push(
            screen: OrderDetailsScreen(orderId: notification.data.id!),
          );
        } else if (notification.data.notificationType ==
            NotificationType.offers) {
          appNavigator.push(
            screen: OfferDetailsScreen(offerId: notification.data.id!),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(8.r),
        ),
        margin: EdgeInsets.symmetric(vertical: 8.sp),
        child: Padding(
          padding: EdgeInsets.all(15.sp),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.circle,
                size: 15.sp,
                color: notification.isSeen
                    ? AppColors.greyDark
                    : AppColors.green,
              ),
              AppSpacer(widthRatio: 0.5),
              Expanded(
                child: Column(
                  spacing: 8.sp,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notification.data.title, style: TextStyles.bold18),
                    HtmlWidget(notification.data.body),
                    Row(
                      children: [
                        if (notification.data.notificationType ==
                            NotificationType.order) ...[
                          Text(
                            LocaleKeys.show_order_details.tr(),
                            style: TextStyles.bold14.copyWith(
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                              decorationThickness: 5.sp,
                            ),
                          ),
                        ] else if (notification.data.notificationType ==
                            NotificationType.offers) ...[
                          Text(
                            LocaleKeys.show_offers.tr(),
                            style: TextStyles.bold14.copyWith(
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                              decorationThickness: 5.sp,
                            ),
                          ),
                        ],
                        Spacer(),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            formatDateTime(notification.createdAt),
                            style: TextStyles.regular14.copyWith(
                              color: AppColors.greyHint,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatDateTime(DateTime dateTime) {
    final time = DateFormat('hh:mm').format(dateTime);
    final period = DateFormat('a', 'ar').format(dateTime);
    final day = DateFormat('d').format(dateTime);
    final month = DateFormat('MMMM', 'ar_SA').format(dateTime);
    final year = DateFormat('y').format(dateTime);

    return '$time $period - $day $month $year';
  }
}

class NotificationCardShimmer extends StatelessWidget {
  const NotificationCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(8.r),
      ),
      margin: EdgeInsets.symmetric(vertical: 8.sp),
      child: Padding(
        padding: EdgeInsets.all(15.sp),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerLoading(
              widget: ShimmerBox(
                height: 15.sp,
                width: 15.sp,
                shape: BoxShape.circle,
              ),
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
                      width: 150.sp,
                      borderRadius: 2.r,
                    ),
                  ),
                  ShimmerLoading(
                    widget: ShimmerBox(
                      height: 20.sp,
                      width: 500.sp,
                      borderRadius: 2.r,
                    ),
                  ),
                  ShimmerLoading(
                    widget: ShimmerBox(
                      height: 20.sp,
                      width: 500.sp,
                      borderRadius: 2.r,
                    ),
                  ),
                  ShimmerLoading(
                    widget: ShimmerBox(
                      height: 20.sp,
                      width: 300.sp,
                      borderRadius: 2.r,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: ShimmerLoading(
                      widget: ShimmerBox(
                        height: 20.sp,
                        width: 150.sp,
                        borderRadius: 2.r,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
