// ignore_for_file: deprecated_member_use
import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/enums/static_data_enum.dart';
import 'package:investhub_app/core/util/token_storge_helper.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/core/widgets/contact_dialog.dart';
import 'package:investhub_app/features/auth/presentation/pages/sign_in/sign_in_screen.dart';
import 'package:investhub_app/features/home/presentation/widgets/visitor_popup_widget.dart';
import 'package:investhub_app/features/orders/presentation/cubits/show_order/show_order_cubit.dart';
import 'package:investhub_app/features/orders/presentation/pages/all_orders_screen.dart';
import 'package:investhub_app/features/profile/presentation/pages/static_screen.dart';
import 'package:investhub_app/features/profile/presentation/pages/send_complaints_screen.dart';
import 'package:investhub_app/features/profile/presentation/widgets/logout_bottom_sheet.dart';
import 'package:investhub_app/features/profile/presentation/widgets/profile_card_item.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = TokenStorageHelper.isLoggedIn;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15.sp),
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                children: [
                  ProfileCardItem(
                    title: LocaleKeys.profile_my_orders.tr(),
                    image: AppAssets.imagesMyOrder,
                    onTap: isLoggedIn
                        ? () {
                            appNavigator.push(
                              screen: BlocProvider(
                                create: (context) => sl<ShowOrderCubit>(),
                                child: AllOrdersScreen(),
                              ),
                            );
                          }
                        : () {
                            appNavigator.showDialog(
                              child: VisitorPopupWidget(),
                            );
                          },
                  ),
                  AppSpacer(heightRatio: 0.1),
                  Divider(),
                  AppSpacer(heightRatio: 0.1),
                  ProfileCardItem(
                    title: LocaleKeys.profile_complaintsAndSuggestions.tr(),
                    image: AppAssets.imagesInfo,
                    onTap: () {
                      isLoggedIn
                          ? appNavigator.push(screen: SendComplainScreen())
                          : appNavigator.showDialog(
                              child: VisitorPopupWidget(),
                            );
                    },
                  ),
                  AppSpacer(heightRatio: 0.1),
                  Divider(),
                  AppSpacer(heightRatio: 0.1),
                  ProfileCardItem(
                    title: LocaleKeys.profile_contact_us.tr(),
                    image: AppAssets.imagesCall,
                    onTap: () {
                      appNavigator.showSheet(child: ContactBottomSheet());
                    },
                  ),
                ],
              ),
            ),
            AppSpacer(heightRatio: 1),
            Container(
              padding: EdgeInsets.all(15.sp),
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                children: [
                  ProfileCardItem(
                    title: LocaleKeys.profile_about_app.tr(),
                    image: AppAssets.imagesInfo,
                    onTap: () => appNavigator.push(
                      screen: StaticScreen(
                        title: LocaleKeys.profile_about_app.tr(),
                        type: getStaticDataTypeString(StaticDataType.about_app),
                      ),
                    ),
                  ),
                  AppSpacer(heightRatio: 0.1),
                  Divider(),
                  AppSpacer(heightRatio: 0.1),
                  ProfileCardItem(
                    title: LocaleKeys.profile_privacy_policy.tr(),
                    image: AppAssets.imagesSecurity,
                    onTap: () => appNavigator.push(
                      screen: StaticScreen(
                        title: LocaleKeys.profile_privacy_policy.tr(),
                        type: getStaticDataTypeString(StaticDataType.privacy),
                      ),
                    ),
                  ),
                  AppSpacer(heightRatio: 0.1),
                  if (isLoggedIn) ...[
                    Divider(),
                    AppSpacer(heightRatio: 0.1),
                    ProfileCardItem(
                      title: LocaleKeys.profile_log_out.tr(),
                      image: AppAssets.imagesLogout,
                      isLogOut: true,
                      onTap: () {
                        appNavigator.showSheet(child: LogOutBottomSheet());
                      },
                    ),
                  ] else ...[
                    Divider(),
                    ProfileCardItem(
                      title: LocaleKeys.auth_signin.tr(),
                      image: AppAssets.imagesLogin,
                      onTap: () {
                        appNavigator.push(screen: const SignInScreen());
                      },
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
