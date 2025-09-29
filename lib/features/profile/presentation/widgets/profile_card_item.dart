import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileCardItem extends StatelessWidget {
  final String title;
  final String image;
  final Function() onTap;
  final bool isLogOut;
  const ProfileCardItem({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
    this.isLogOut = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: isLogOut
                ? AppColors.red.withOpacity(0.1)
                : AppColors.white,
            radius: 20.r,
            child: SvgPicture.asset(image),
          ),
          AppSpacer(widthRatio: 0.7),
          Text(
            title,
            style: TextStyles.semiBold16.copyWith(
              color: isLogOut ? AppColors.red : AppColors.black,
            ),
          ),
          Spacer(),
          CircleAvatar(
            radius: 20.r,
            backgroundColor: AppColors.white,
            child: Icon(
              Icons.arrow_forward_rounded,
              size: 22.sp,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
