import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/core/widgets/cached_image.dart';
import 'package:investhub_app/features/home/data/models/all_departments_response.dart';
import 'package:investhub_app/features/home/presentation/pages/department_products_screen.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class DepartmentTileItem extends StatelessWidget {
  final Department department;
  const DepartmentTileItem({super.key, required this.department});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        appNavigator.push(
          screen: DepartmentProductsScreen(department: department),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CacheNetworkImage(
                width: 55.sp,
                height: 55.sp,
                fit: BoxFit.scaleDown,
                imageUrl: department.image,
              ),
              AppSpacer(widthRatio: 1),
              Text(
                department.name,
                style: TextStyles.bold16,
                overflow: TextOverflow.ellipsis,
              ),
              Spacer(),
              CircleAvatar(
                backgroundColor: AppColors.primaryLight,
                radius: 20.r,
                child: Icon(
                  Icons.arrow_forward_rounded,
                  size: 20.sp,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DepartmentTileShimmer extends StatelessWidget {
  const DepartmentTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemCount: 15,
      separatorBuilder: (context, index) => AppSpacer(heightRatio: 0.4),
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: 55.sp,
                  height: 50.sp,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                ),
              ),
              AppSpacer(widthRatio: 1),
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: 100.sp,
                  height: 25.sp,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                ),
              ),
              Spacer(),
              CircleAvatar(
                backgroundColor: AppColors.primaryLight,
                radius: 20.r,
                child: Icon(
                  Icons.arrow_forward_rounded,
                  size: 20.sp,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
