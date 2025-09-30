import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/features/home/domain/entities/bottom_navigation_entity.dart';
import 'package:investhub_app/features/home/presentation/cubit/bottom_navigation/bottom_navigation_cubit.dart';

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
                    Image.asset(
                      items[index].icon,
                      width: 25.sp,
                      height: 25.sp,
                      color: isActive ? AppColors.primary : AppColors.greyDark,
                    ),
                    AppSpacer(widthRatio: 0.5),
                    Text(
                      items[index].title.tr(),
                      style: TextStyles.semiBold16.copyWith(
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
