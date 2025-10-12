// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/size_config.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/core/widgets/spinner_loading.dart';
import 'package:investhub_app/core/widgets/toast.dart';
import 'package:investhub_app/features/home/domain/entities/subscription_package.dart';
import 'package:investhub_app/features/home/presentation/cubit/subscribe/subscribe_cubit.dart';
import 'package:investhub_app/features/home/presentation/cubit/subscriptions/subscriptions_cubit.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SubscriptionsCubit>(
      create: (context) => sl<SubscriptionsCubit>()..getSubscriptions(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.home_subscriptions.tr()),
          elevation: 0.2,
          automaticallyImplyLeading: false,
        ),
        body: BlocBuilder<SubscriptionsCubit, SubscriptionsState>(
          builder: (context, state) {
            if (state is SubscriptionsLoading) {
              return const Center(child: SpinnerLoading());
            } else if (state is SubscriptionsSuccess) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<SubscriptionsCubit>().getSubscriptions();
                },
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const AppSpacer(heightRatio: 1.5),
                  padding: SizeConfig.paddingSymmetric,
                  itemCount: state.subscriptions.length,
                  itemBuilder: (context, index) {
                    return SubscriptionCard(
                      subscription: state.subscriptions[index],
                      onSubscribeSuccess: () {
                        context.read<SubscriptionsCubit>().getSubscriptions();
                      },
                    );
                  },
                ),
              );
            } else if (state is SubscriptionsError) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<SubscriptionsCubit>().getSubscriptions();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.message,
                            style: TextStyles.regular16.copyWith(
                              color: AppColors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const AppSpacer(heightRatio: 1),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<SubscriptionsCubit>()
                                  .getSubscriptions();
                            },
                            child: Text(LocaleKeys.retry.tr()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  final SubscriptionPackage subscription;
  final Function() onSubscribeSuccess;
  const SubscriptionCard({
    super.key,
    required this.subscription,
    required this.onSubscribeSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SubscribeCubit>(
      create: (context) => sl<SubscribeCubit>(),
      child: _SubscriptionCardContent(
        subscription: subscription,
        onSubscribeSuccess: onSubscribeSuccess,
      ),
    );
  }
}

class _SubscriptionCardContent extends StatelessWidget {
  final SubscriptionPackage subscription;
  final Function() onSubscribeSuccess;
  const _SubscriptionCardContent({
    required this.subscription,
    required this.onSubscribeSuccess,
  });

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
        border: subscription.isPopular
            ? Border.all(color: Theme.of(context).primaryColor)
            : null,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (subscription.isPopular) SizedBox(height: 20.sp),
          CircleAvatar(
            radius: 18.r,
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Icon(
              Icons.star_rounded,
              color: Theme.of(context).primaryColor,
            ),
          ),
          AppSpacer(heightRatio: 0.7),
          Text(
            subscription.name,
            style: TextStyles.bold20.copyWith(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          AppSpacer(heightRatio: 0.3),
          Text(
            subscription.description,
            style: TextStyles.regular16.copyWith(
              color: Theme.of(
                context,
              ).textTheme.bodyMedium?.color?.withOpacity(0.7),
            ),
          ),
          AppSpacer(heightRatio: 0.7),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                subscription.formattedPrice,
                style: TextStyles.bold24.copyWith(
                  fontSize: 40.sp,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              // AppSpacer(widthRatio: 0.5),
              // Image.asset(AppAssets.imagesSaudiRiyalSymbol, height: 18.sp),
            ],
          ),
          AppSpacer(heightRatio: 0.7),
          if (subscription.features?.isNotEmpty ?? false) ...[
            Column(
              children:
                  subscription.features
                      ?.map(
                        (feature) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.sp),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Theme.of(context).primaryColor,
                                size: 16.sp,
                              ),
                              AppSpacer(widthRatio: 0.3),
                              Expanded(
                                child: Text(
                                  feature,
                                  style: TextStyles.regular14.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.color
                                        ?.withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList() ??
                  [],
            ),
            AppSpacer(heightRatio: 0.7),
          ],
          // Show different UI based on subscription status
          subscription.isSubscribed
              ? Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12.sp),
                  decoration: BoxDecoration(
                    color: AppColors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: AppColors.green, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: AppColors.green,
                        size: 20.sp,
                      ),
                      AppSpacer(widthRatio: 0.5),
                      Text(
                        LocaleKeys.currently_subscribed.tr(),
                        style: TextStyles.semiBold16.copyWith(
                          color: AppColors.green,
                        ),
                      ),
                    ],
                  ),
                )
              : BlocConsumer<SubscribeCubit, SubscribeState>(
                  listener: (context, subscribeState) {
                    if (subscribeState is SubscribeSuccess) {
                      showSucessToast(subscribeState.message);
                      onSubscribeSuccess();
                    }
                  },
                  builder: (context, subscribeState) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: subscribeState is SubscribeLoading
                            ? null
                            : () {
                                context.read<SubscribeCubit>().subscribeEvent(
                                  subscriptionId: subscription.id,
                                );
                              },
                        child: subscribeState is SubscribeLoading
                            ? SizedBox(
                                height: 20.sp,
                                width: 20.sp,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.white,
                                  ),
                                ),
                              )
                            : Text(LocaleKeys.subscribe_now.tr()),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}

//  if (subscription.isPopular)
//           Positioned(
//             top: -14,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: AppColors.primary,
//                   borderRadius: BorderRadius.circular(30.r),
//                 ),
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 10.sp,
//                   vertical: 10.sp,
//                 ),
//                 child: Text(
//                   "الأكثر شعبية",
//                   style: TextStyles.bold12.copyWith(color: AppColors.white),
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
