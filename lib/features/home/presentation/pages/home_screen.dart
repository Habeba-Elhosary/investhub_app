import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/features/home/presentation/cubits/all_departments/all_deparments_cubit.dart';
import 'package:investhub_app/features/home/presentation/cubits/all_products/all_batteries_cubit.dart';
import 'package:investhub_app/features/home/presentation/cubits/all_products/all_tires_cubit.dart';
import 'package:investhub_app/features/home/presentation/pages/all_departments_screen.dart';
import 'package:investhub_app/features/home/presentation/pages/all_batteries_screen.dart';
import 'package:investhub_app/features/home/presentation/pages/all_offers_screen.dart';
import 'package:investhub_app/features/home/presentation/pages/all_tires_screen.dart';
import 'package:investhub_app/features/home/presentation/widgets/all_batteries_section.dart';
import 'package:investhub_app/features/home/presentation/widgets/all_departments_section.dart';
import 'package:investhub_app/features/home/presentation/widgets/all_tires_section.dart';
import 'package:investhub_app/features/home/presentation/widgets/home_appbar.dart';
import 'package:investhub_app/features/home/presentation/widgets/section_header.dart';
import 'package:investhub_app/features/notifications/presentation/cubits/unread_notification_count/unread_count_cubit.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<AllDeparmentsCubit>(
            create: (context) => sl<AllDeparmentsCubit>(),
          ),
          BlocProvider<AllTiresCubit>(create: (context) => sl<AllTiresCubit>()),
          BlocProvider<AllBatteriesCubit>(
            create: (context) => sl<AllBatteriesCubit>(),
          ),
        ],
        child: BlocBuilder<AllDeparmentsCubit, AllDeparmentsState>(
          builder: (context, state) {
            final AllDeparmentsCubit allDeparmentsCubit = context
                .read<AllDeparmentsCubit>();
            return BlocBuilder<AllTiresCubit, AllTiresState>(
              builder: (context, state) {
                final AllTiresCubit allTiresCubit = context
                    .read<AllTiresCubit>();
                return BlocBuilder<AllBatteriesCubit, AllBatteriesState>(
                  builder: (context, state) {
                    final AllBatteriesCubit allBatteriesCubit = context
                        .read<AllBatteriesCubit>();
                    return SafeArea(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          allDeparmentsCubit.getDepartmentsForFirstTime();
                          allTiresCubit.getTiresForFirstTime();
                          allBatteriesCubit.getBatteriesForFirstTime();
                          context.read<UnreadCountCubit>().getUnreadCount();
                        },
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(vertical: 16.sp),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.sp,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    appNavigator.push(
                                      screen: AllOffersScreen(),
                                    );
                                  },
                                  child: Image.asset(
                                    AppAssets.imagesOffers,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              AppSpacer(heightRatio: 1),
                              SectionHeader(
                                title: LocaleKeys.home_all_categories.tr(),
                                actionText: LocaleKeys.more.tr(),
                                onActionTap: () {
                                  appNavigator.push(
                                    screen: AllDepartmentsScreen(),
                                  );
                                },
                              ),
                              AppSpacer(heightRatio: 0.7),
                              AllDepartmentsSection(
                                allDeparmentsCubit: allDeparmentsCubit,
                              ),
                              AppSpacer(heightRatio: 1.5),
                              SectionHeader(
                                title: LocaleKeys.home_all_batteries.tr(),
                                actionText: LocaleKeys.more.tr(),
                                onActionTap: () {
                                  appNavigator.push(
                                    screen: AllBatteriesScreen(),
                                  );
                                },
                              ),
                              AppSpacer(heightRatio: 0.7),
                              AllBatteriesSection(
                                allBatteriesCubit: allBatteriesCubit,
                              ),
                              AppSpacer(heightRatio: 1.5),
                              SectionHeader(
                                title: LocaleKeys.home_all_tires.tr(),
                                actionText: LocaleKeys.more.tr(),
                                onActionTap: () {
                                  appNavigator.push(screen: AllTiresScreen());
                                },
                              ),
                              AppSpacer(heightRatio: 0.7),
                              AllTiresSection(allTiresCubit: allTiresCubit),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
