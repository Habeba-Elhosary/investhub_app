import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/util/token_storge_helper.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/features/home/domain/entities/bottom_navigation_entity.dart';
import 'package:investhub_app/features/home/presentation/cubits/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:investhub_app/features/notifications/presentation/cubits/unread_notification_count/unread_count_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final List<BottomNavigationEntity> items = context
        .read<BottomNavigationCubit>()
        .items;
    return BlocBuilder<BottomNavigationCubit, int>(
      builder: (context, currentIndex) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryLight,
                blurRadius: 50,
                spreadRadius: 0,
                offset: const Offset(0, -5),
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
          ),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            onTap: (index) async {
              context.read<BottomNavigationCubit>().changeIndex(index);
              final bool hasToken = await TokenStorageHelper.hasValidToken();
              if (hasToken) {
                Future.microtask(() {
                  // ignore: use_build_context_synchronously
                  context.read<UnreadCountCubit>().getUnreadCount();
                });
              }
            },
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.greyDark,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            items: List.generate(items.length, (index) {
              final isActive = currentIndex == index;
              return BottomNavigationBarItem(
                label: '',
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      isActive ? items[index].activeIcon : items[index].icon,
                      width: 30.sp,
                      height: 30.sp,
                      colorFilter: ColorFilter.mode(
                        isActive ? AppColors.primary : AppColors.greyDark,
                        BlendMode.srcIn,
                      ),
                    ),
                    AppSpacer(widthRatio: 0.5),
                    Text(
                      items[index].title,
                      style: TextStyles.bold16.copyWith(
                        color: isActive
                            ? AppColors.primary
                            : AppColors.greyDark,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }
}


// Will Need it Later
      // return AnimatedBottomNavigationBar.builder(
        //   itemCount: items.length,
        //   height: 70,
        //   tabBuilder: (index, isActive) {
        //     return Row(
        //       mainAxisSize: MainAxisSize.min,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         SvgPicture.asset(
        //           isActive ? items[index].activeIcon : items[index].icon,
        //           height: 24.h,
        //           width: 24.w,
        //         ),
        //         SizedBox(width: 8.w),
        //         Text(
        //           items[index].title,
        //           style: TextStyles.bold14.copyWith(
        //             color:
        //                 isActive ? AppColors.primary : const Color(0xffAAACB1),
        //           ),
        //         ),
        //       ],
        //     );
        //   },
        //   activeIndex: index,
        //   notchSmoothness: NotchSmoothness.sharpEdge,
        //   onTap:
        //       (index) =>
        //           context.read<BottomNavigationCubit>().changeIndex(index),
        // );