import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/util/request_status.dart';
import 'package:investhub_app/features/notifications/presentation/cubits/mark_all_notification_read/mark_all_as_read_cubit.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MakeAllNotificationReadButton extends StatelessWidget {
  const MakeAllNotificationReadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MarkAllAsReadCubit, MarkAllAsReadState, RequestStatus>(
      selector: (MarkAllAsReadState state) {
        return state.requestStatus;
      },
      builder: (BuildContext context, RequestStatus state) {
        return Visibility(
          visible: state != RequestStatus.loading,
          replacement: Padding(
            padding: EdgeInsets.only(left: 20.sp),
            child: Center(
              child: SizedBox(
                height: 30.sp,
                width: 30.sp,
                child: CircularProgressIndicator.adaptive(strokeWidth: 3.sp),
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: GestureDetector(
              onTap: () {
                context.read<MarkAllAsReadCubit>().markAllAsReadEvent();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 0),
                child: Center(
                  child: Text(
                    LocaleKeys.notifications_read_all.tr(),
                    style: TextStyles.regular14.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
