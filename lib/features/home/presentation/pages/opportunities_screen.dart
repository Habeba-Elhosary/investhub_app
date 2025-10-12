// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/size_config.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/core/widgets/spinner_loading.dart';
import 'package:investhub_app/features/home/domain/entities/opportunity.dart';
import 'package:investhub_app/features/home/presentation/cubit/opportunities/opportunities_cubit.dart';
import 'package:investhub_app/features/home/presentation/pages/opportunity_details_screen.dart';
import 'package:investhub_app/features/home/presentation/cubit/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:investhub_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';

class OpportunitiesScreen extends StatefulWidget {
  const OpportunitiesScreen({super.key});

  @override
  State<OpportunitiesScreen> createState() => _OpportunitiesScreenState();
}

class _OpportunitiesScreenState extends State<OpportunitiesScreen> {
  bool _isSubscribed = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkSubscriptionStatus();
  }

  Future<void> _checkSubscriptionStatus() async {
    try {
      final localDataSource = sl<AuthLocalDataSource>();
      final user = await localDataSource.getCacheUser();
      setState(() {
        _isSubscribed = user.isSubscribed;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isSubscribed = false;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OpportunitiesCubit>(
      create: (context) => sl<OpportunitiesCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.home_oppurtunities.tr()),
          automaticallyImplyLeading: false,
          elevation: 0.2,
        ),
        body: _isLoading
            ? const Center(child: SpinnerLoading())
            : !_isSubscribed
            ? _buildSubscriptionRequiredWidget()
            : BlocBuilder<OpportunitiesCubit, OpportunitiesState>(
                builder: (context, state) {
                  final cubit = context.read<OpportunitiesCubit>();
                  return RefreshIndicator(
                    onRefresh: () => Future.sync(() => cubit.refresh()),
                    child: PagedListView<int, Opportunity>(
                      pagingController: cubit.pagingController,
                      padding: SizeConfig.paddingSymmetric,
                      builderDelegate: PagedChildBuilderDelegate<Opportunity>(
                        itemBuilder: (context, opportunity, index) {
                          return Column(
                            children: [
                              OpportunityCard(opportunity: opportunity),
                              if (index <
                                  cubit.pagingController.itemList!.length - 1)
                                const AppSpacer(heightRatio: 0.5),
                            ],
                          );
                        },
                        firstPageErrorIndicatorBuilder: (context) => Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                LocaleKeys.error_loading_data.tr(),
                                style: TextStyles.regular16.copyWith(
                                  color: AppColors.red,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const AppSpacer(heightRatio: 1),
                              ElevatedButton(
                                onPressed: () => cubit.refresh(),
                                child: Text(LocaleKeys.retry.tr()),
                              ),
                            ],
                          ),
                        ),
                        newPageErrorIndicatorBuilder: (context) => Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                LocaleKeys.error_loading_more.tr(),
                                style: TextStyles.regular16.copyWith(
                                  color: AppColors.red,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const AppSpacer(heightRatio: 1),
                              ElevatedButton(
                                onPressed: () => cubit.pagingController
                                    .retryLastFailedRequest(),
                                child: Text(LocaleKeys.retry.tr()),
                              ),
                            ],
                          ),
                        ),
                        firstPageProgressIndicatorBuilder: (context) =>
                            const Center(child: SpinnerLoading()),
                        newPageProgressIndicatorBuilder: (context) =>
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(child: CircularProgressIndicator()),
                            ),
                        noMoreItemsIndicatorBuilder: (context) =>
                            const SizedBox.shrink(),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _buildSubscriptionRequiredWidget() {
    return Center(
      child: Padding(
        padding: SizeConfig.paddingSymmetric,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_outline, size: 80.sp, color: AppColors.greyLight),
            AppSpacer(heightRatio: 2),
            Text(
              LocaleKeys.subscription_required.tr(),
              style: TextStyles.bold24.copyWith(color: AppColors.primary),
              textAlign: TextAlign.center,
            ),
            AppSpacer(heightRatio: 1),
            Text(
              LocaleKeys.subscription_required_message.tr(),
              style: TextStyles.regular16.copyWith(color: AppColors.greyLight),
              textAlign: TextAlign.center,
            ),
            AppSpacer(heightRatio: 2),
            ElevatedButton(
              onPressed: () {
                context.read<BottomNavigationCubit>().changeIndex(1);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                LocaleKeys.home_subscriptions.tr(),
                style: TextStyles.semiBold16.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OpportunityCard extends StatelessWidget {
  final Opportunity opportunity;
  const OpportunityCard({super.key, required this.opportunity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.greyLight.withOpacity(0.2)
                : Theme.of(context).shadowColor.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.sp,
                  vertical: 7.sp,
                ),
                decoration: BoxDecoration(
                  color: opportunity.isHalal
                      ? AppColors.green.withOpacity(0.1)
                      : Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(40.r),
                ),
                child: Text(
                  opportunity.marketName,
                  style: TextStyles.regular14.copyWith(
                    color: !opportunity.isAmerican
                        ? AppColors.green
                        : AppColors.rejectText,
                  ),
                ),
              ),
              const Spacer(),
              Image.asset(
                opportunity.isHalal ? AppAssets.halal : AppAssets.nonHalal,
                width: 28.w,
                height: 28.h,
              ),
            ],
          ),
          AppSpacer(heightRatio: 0.7),
          Text(
            opportunity.companyName,
            style: TextStyles.bold20.copyWith(
              color: Theme.of(context).primaryColor,
            ),
          ),
          AppSpacer(heightRatio: 0.3),
          Text(
            opportunity.sectorName,
            style: TextStyles.regular14.copyWith(
              color: Theme.of(
                context,
              ).textTheme.bodyMedium?.color?.withOpacity(0.7),
            ),
          ),
          AppSpacer(heightRatio: 0.7),
          Row(
            children: [
              Text(
                '${LocaleKeys.current_price.tr()} : ',
                style: TextStyles.regular16.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              AppSpacer(heightRatio: 0.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    opportunity.currentPrice,
                    style: TextStyles.bold18.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  AppSpacer(widthRatio: 0.2),
                  Image.asset(AppAssets.imagesSaudiRiyalSymbol, height: 18.sp),
                ],
              ),
              Spacer(),
              Text(
                '${LocaleKeys.entry_price.tr()} : ',
                style: TextStyles.regular16.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              AppSpacer(heightRatio: 0.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    opportunity.entryPrice,
                    style: TextStyles.bold18.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  AppSpacer(widthRatio: 0.2),
                  Image.asset(AppAssets.imagesSaudiRiyalSymbol, height: 18.sp),
                ],
              ),
            ],
          ),
          AppSpacer(heightRatio: 0.7),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Transform.flip(
                flipY: true,
                child: Icon(
                  Icons.show_chart_rounded,
                  color: Theme.of(context).primaryColor,
                  size: 20.sp,
                ),
              ),
              AppSpacer(widthRatio: 0.3),
              Text(
                '${LocaleKeys.expected_return.tr()} : ',
                style: TextStyles.regular16.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              Spacer(),
              Text(
                '+${opportunity.expectedReturnPercentage}%',
                style: TextStyles.bold20.copyWith(color: AppColors.green),
              ),
            ],
          ),
          AppSpacer(heightRatio: 0.7),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                appNavigator.push(
                  screen: OpportunityDetailsScreen(opportunity: opportunity),
                );
              },
              child: Text(LocaleKeys.opportunity_details.tr()),
            ),
          ),
        ],
      ),
    );
  }
}
