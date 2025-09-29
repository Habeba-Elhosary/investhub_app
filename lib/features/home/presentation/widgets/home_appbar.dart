import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/util/token_storge_helper.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/features/cart/presentation/pages/cart_screen.dart';
import 'package:investhub_app/features/home/presentation/widgets/visitor_popup_widget.dart';
import 'package:investhub_app/features/notifications/presentation/widgets/notification_icon.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      title: FutureBuilder<bool>(
        future: TokenStorageHelper.hasValidToken(),
        builder: (context, snapshot) {
          final isLoggedIn = snapshot.data ?? false;

          return Row(
            children: [
              Image.asset(AppAssets.imagesLogo, width: 43.sp),
              const Spacer(),

              GestureDetector(
                onTap: () {
                  if (isLoggedIn) {
                    appNavigator.push(screen: CartScreen());
                  } else {
                    appNavigator.showDialog(child: VisitorPopupWidget());
                  }
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 18.r,
                  child: SvgPicture.asset(AppAssets.imagesCart, height: 25.sp),
                ),
              ),

              AppSpacer(widthRatio: 0.5),

              if (isLoggedIn) ...[
                NotificationUserIcon(),
              ] else ...[
                NotificationVisitorIcon(),
              ],
            ],
          );
        },
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryLight, AppColors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      shadowColor: AppColors.primaryLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.r),
          bottomRight: Radius.circular(16.r),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.h);
}
