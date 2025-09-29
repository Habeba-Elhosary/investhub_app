// ignore_for_file: unnecessary_underscores

import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/enums/order_type_enum.dart';
import 'package:investhub_app/core/util/request_status.dart';
import 'package:investhub_app/core/widgets/app_error_widget.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/features/orders/data/models/orders_response.dart';
import 'package:investhub_app/features/orders/presentation/cubits/show_order/show_order_cubit.dart';
import 'package:investhub_app/features/orders/presentation/widgets/order_card_item.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<ShowOrderCubit>().initScoll();
    context.read<ShowOrderCubit>().initialize(this);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ShowOrderCubit>();
    final tabController = cubit.tabController;
    final orderTypes = cubit.orderTypes;

    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocBuilder<ShowOrderCubit, ShowOrderState>(
        builder: (context, state) {
          return TabBarView(
            controller: tabController,
            physics: const BouncingScrollPhysics(),
            children: orderTypes.map((type) {
              return BlocSelector<
                ShowOrderCubit,
                ShowOrderState,
                RequestStatus
              >(
                selector: (state) => state.allRequestStatus,
                builder: (context, allState) {
                  if (allState == RequestStatus.loading ||
                      state.orderType != type) {
                    return ListView.builder(
                      padding: EdgeInsets.all(16.sp),
                      itemCount: 10,
                      itemBuilder: (context, index) =>
                          const OrderCardItemShimmer(),
                    );
                  }

                  if (allState == RequestStatus.error) {
                    return BlocSelector<ShowOrderCubit, ShowOrderState, String>(
                      selector: (state) {
                        return state.generalErrorMessage;
                      },
                      builder: (context, state) {
                        return AppErrorWidget(
                          errorMessage: state,
                          onRetry: () => cubit.getOrdersForFirstTime(),
                        );
                      },
                    );
                  }

                  if (allState == RequestStatus.success) {
                    return BlocSelector<
                      ShowOrderCubit,
                      ShowOrderState,
                      List<OrderData>
                    >(
                      selector: (state) => state.orders,
                      builder: (context, allOrdersState) {
                        if (allOrdersState.isEmpty) {
                          return Center(
                            child: Text(
                              LocaleKeys.order_no_orders.tr(),
                              style: TextStyles.bold18,
                            ),
                          );
                        }

                        return Column(
                          children: [
                            Expanded(
                              child: RefreshIndicator(
                                onRefresh: () async => cubit.refreshOrders(),
                                color: AppColors.primary,
                                child: ListView.separated(
                                  controller: cubit.scrollController,
                                  padding: EdgeInsets.all(16.sp),
                                  itemCount: allOrdersState.length,
                                  separatorBuilder: (_, __) =>
                                      AppSpacer(heightRatio: 0.8),
                                  itemBuilder: (_, index) => OrderCardItem(
                                    orderData: allOrdersState[index],
                                    orderType: state.orderType,
                                  ),
                                ),
                              ),
                            ),
                            BlocSelector<
                              ShowOrderCubit,
                              ShowOrderState,
                              RequestStatus
                            >(
                              selector: (pState) {
                                return pState.paginationRequestStatus;
                              },
                              builder:
                                  (BuildContext context, RequestStatus state) {
                                    if (state == RequestStatus.loading) {
                                      return Center(
                                        child:
                                            CircularProgressIndicator.adaptive(),
                                      );
                                    }
                                    if (state == RequestStatus.error) {
                                      return Center(
                                        child:
                                            BlocSelector<
                                              ShowOrderCubit,
                                              ShowOrderState,
                                              String
                                            >(
                                              selector: (pState) {
                                                return pState
                                                    .paginationErrorMessage;
                                              },
                                              builder:
                                                  (
                                                    BuildContext context,
                                                    String state,
                                                  ) {
                                                    return AppErrorWidget(
                                                      onRetry: () {
                                                        context
                                                            .read<
                                                              ShowOrderCubit
                                                            >()
                                                            .loadMoreOrders();
                                                      },
                                                      errorMessage: state,
                                                    );
                                                  },
                                            ),
                                      );
                                    }
                                    return Container();
                                  },
                            ),
                          ],
                        );
                      },
                    );
                  }
                  return SizedBox.shrink();
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    final cubit = context.read<ShowOrderCubit>();
    final tabController = cubit.tabController;
    final orderTypes = cubit.orderTypes;

    return AppBar(
      title: Text(LocaleKeys.profile_my_orders.tr()),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: BlocSelector<ShowOrderCubit, ShowOrderState, OrderType>(
          selector: (state) => state.orderType,
          builder: (context, orderType) {
            return TabBar(
              controller: tabController,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white,
              unselectedLabelColor: const Color(0xff7B8A9D),
              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
              labelPadding: EdgeInsets.symmetric(horizontal: 20.w),
              indicator: BoxDecoration(
                color: orderType.color,
                borderRadius: BorderRadius.circular(8.r),
              ),
              tabs: orderTypes
                  .map(
                    (order) => Tab(
                      height: 40.sp,
                      child: Padding(
                        padding: EdgeInsets.only(top: 4.sp),
                        child: Text(order.label, style: TextStyles.regular16),
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
