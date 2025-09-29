import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/features/home/presentation/widgets/visitor_popup_widget.dart';
import 'package:investhub_app/features/notifications/presentation/cubits/unread_notification_count/unread_count_cubit.dart';
import 'package:investhub_app/features/notifications/presentation/pages/notifications_screen.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NotificationUserIcon extends StatelessWidget {
  const NotificationUserIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UnreadCountCubit, UnreadCountState, int>(
      selector: (UnreadCountState state) {
        return state.unreadCount;
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => appNavigator.push(screen: const NotificationsScreen()),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 18.r,
                child: SvgPicture.asset(
                  AppAssets.imagesNotification,
                  height: 25.sp,
                ),
              ),
              if (state > 0)
                Positioned(
                  right: 1.sp,
                  top: 0.sp,
                  child: Icon(
                    Icons.circle,
                    size: 13.sp,
                    color: AppColors.primary,
                  ),
                ).animate().scaleXY(),
            ],
          ),
        );
      },
    );
  }
}

class NotificationVisitorIcon extends StatelessWidget {
  const NotificationVisitorIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        appNavigator.showDialog(child: VisitorPopupWidget());
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 18.r,
            child: SvgPicture.asset(
              AppAssets.imagesNotification,
              height: 25.sp,
            ),
          ),
        ],
      ),
    );
  }
}
