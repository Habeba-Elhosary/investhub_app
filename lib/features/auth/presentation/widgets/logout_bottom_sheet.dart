import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';

class LogOutBottomSheet extends StatelessWidget {
  final Function() onLogout;
  const LogOutBottomSheet({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.sp, right: 16.sp, bottom: 30.sp),
      child:
          // BlocProvider<LogoutCubit>(
          //   create: (context) => sl<LogoutCubit>(),
          //   child: BlocBuilder<LogoutCubit, LogoutState>(
          //     builder: (context, state) {
          //       return
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  LocaleKeys.profile_log_out.tr(),
                  style: TextStyles.bold20.copyWith(color: AppColors.red),
                ),
              ),
              AppSpacer(heightRatio: 1),
              Text(
                LocaleKeys.profile_log_out_message.tr(),
                style: TextStyles.regular18,
              ),
              AppSpacer(heightRatio: 1.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 10.sp,
                children: [
                  Expanded(
                    child:
                        // Visibility(
                        //     visible: state is! LogoutLoading,
                        //     replacement: const SpinnerLoading(),
                        //     child:
                        ElevatedButton(
                          onPressed: () {
                            onLogout();
                            // context.read<LogoutCubit>().logoutEvent();
                          },
                          child: Text(
                            LocaleKeys.yes.tr(),
                            style: TextStyles.bold18,
                          ),
                        ),
                  ),
                  // ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        appNavigator.pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        elevation: 0,
                        side: BorderSide(color: AppColors.primary),
                      ),
                      child: Text(
                        LocaleKeys.no.tr(),
                        style: TextStyles.bold18.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
      // );
      // },
      //   ),
      // ),
    );
  }
}
