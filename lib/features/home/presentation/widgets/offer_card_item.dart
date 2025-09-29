import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/core/widgets/cached_image.dart';
import 'package:investhub_app/core/widgets/shimmer_loading.dart';
import 'package:investhub_app/features/home/data/models/all_offers_response.dart';
import 'package:investhub_app/features/home/presentation/pages/offer_details_screen.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OfferCardItem extends StatefulWidget {
  final OfferSummary offer;

  const OfferCardItem({super.key, required this.offer});

  @override
  State<OfferCardItem> createState() => _OfferCardItemState();
}

class _OfferCardItemState extends State<OfferCardItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        appNavigator.push(screen: OfferDetailsScreen(offerId: widget.offer.id));
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
                imageUrl: widget.offer.image,
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
                    widget.offer.title,
                    style: TextStyles.regular16,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    widget.offer.description,
                    style: TextStyles.regular14.copyWith(
                      color: AppColors.greyHint,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
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

class OfferCardShimmer extends StatelessWidget {
  const OfferCardShimmer({super.key});

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
                    width: double.infinity,
                    height: 15.sp,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                ShimmerLoading(
                  widget: Container(
                    width: double.infinity,
                    height: 15.sp,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
