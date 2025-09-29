import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/core/widgets/shimmer_box.dart';
import 'package:investhub_app/core/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StaticDataShimmer extends StatelessWidget {
  const StaticDataShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => AppSpacer(heightRatio: 0.5),
      padding: EdgeInsets.all(16.sp),
      itemCount: 10,
      itemBuilder: (context, index) => Column(
        spacing: 8.sp,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ShimmerLoading(
            widget: ShimmerBox(height: 20.sp, width: 250.sp, borderRadius: 2.r),
          ),
          ShimmerLoading(
            widget: ShimmerBox(
              height: 20.sp,
              width: double.infinity,
              borderRadius: 2.r,
            ),
          ),
          ShimmerLoading(
            widget: ShimmerBox(
              height: 20.sp,
              width: double.infinity,
              borderRadius: 2.r,
            ),
          ),
          ShimmerLoading(
            widget: ShimmerBox(
              height: 20.sp,
              width: double.infinity,
              borderRadius: 2.r,
            ),
          ),
          ShimmerLoading(
            widget: ShimmerBox(
              height: 20.sp,
              width: double.infinity,
              borderRadius: 2.r,
            ),
          ),
        ],
      ),
    );
  }
}
