import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/util/token_storge_helper.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/features/auth/data/models/auth_response.dart';
import 'package:investhub_app/features/auth/presentation/cubits/auto_login/auto_login_cubit.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = TokenStorageHelper.isLoggedIn;

    if (!isLoggedIn) {
      return Column(
        children: [
          Text(
            LocaleKeys.profile_personal_account.tr(),
            style: TextStyles.bold20.copyWith(color: AppColors.white),
          ),
          AppSpacer(heightRatio: 1.5),
          CircleAvatar(
            radius: 50.r,
            backgroundColor: AppColors.grey,
            child: Icon(Icons.person, size: 50.sp, color: AppColors.white),
          ),
          AppSpacer(heightRatio: 0.4),
          Text(LocaleKeys.profile_visitor.tr(), style: TextStyles.bold20),
          AppSpacer(heightRatio: 0.4),
          Text(
            LocaleKeys.profile_login_to_view_profile.tr(),
            style: TextStyles.regular16.copyWith(color: AppColors.greyHint),
          ),
        ],
      );
    }
    final User user = context.read<AutoLoginCubit>().user;
    return Column(
      children: [
        Text(
          LocaleKeys.profile_personal_account.tr(),
          style: TextStyles.bold20.copyWith(color: AppColors.white),
        ),
        AppSpacer(heightRatio: 1.5),
        CircleAvatar(
          radius: 50.r,
          backgroundColor: AppColors.grey,
          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: Image.asset(
              AppAssets.imagesLogo,
              fit: BoxFit.scaleDown,
              height: 70.sp,
            ),
          ),
        ),
        AppSpacer(heightRatio: 0.4),
        Text(user.name, style: TextStyles.bold20),
        AppSpacer(heightRatio: 0.4),
        Text(
          user.phone,
          style: TextStyles.regular16.copyWith(color: Color(0xff000000)),
        ),
      ],
    );
  }
}
