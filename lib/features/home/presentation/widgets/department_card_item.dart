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

class DepartmentCardItem extends StatelessWidget {
  final Department department;

  const DepartmentCardItem({super.key, required this.department});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        appNavigator.push(
          screen: DepartmentProductsScreen(department: department),
        );
      },
      child: SizedBox(
        width: 130.sp,
        height: 130.sp,
        child: Container(
          padding: EdgeInsets.all(16.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: AppColors.grey,
          ),
          child: FittedBox(
            child: Column(
              children: [
                Text(department.name, style: TextStyles.bold12),
                AppSpacer(heightRatio: 0.2),
                CacheNetworkImage(
                  fit: BoxFit.scaleDown,
                  height: 64.sp,
                  width: 64.sp,
                  imageUrl: department.image,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DepartmentCardItemShimmer extends StatelessWidget {
  const DepartmentCardItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      itemCount: 10,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => AppSpacer(widthRatio: 0.5),
      itemBuilder: (context, index) => SizedBox(
        width: 130.sp,
        height: 130.sp,
        child: Container(
          padding: EdgeInsets.all(16.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: AppColors.grey,
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: FittedBox(
              child: Column(
                children: [
                  Container(
                    width: 90.sp,
                    height: 20.sp,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  ),
                  AppSpacer(heightRatio: 1),
                  Container(
                    width: 120.sp,
                    height: 100.sp,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
