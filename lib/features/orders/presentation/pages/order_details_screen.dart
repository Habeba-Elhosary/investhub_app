import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/enums/order_type_enum.dart';
import 'package:investhub_app/core/widgets/app_error_widget.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/core/widgets/shimmer_box.dart';
import 'package:investhub_app/core/widgets/shimmer_loading.dart';
import 'package:investhub_app/features/orders/data/models/orders_details_response.dart';
import 'package:investhub_app/features/orders/presentation/cubits/show_order_details/show_order_details_cubit.dart';
import 'package:investhub_app/features/orders/presentation/widgets/order_details_card_item.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int orderId;
  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<ShowOrderDetailsCubit>()..showOrderDetails(widget.orderId),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: Text(LocaleKeys.order_order_details.tr())),
            body: BlocBuilder<ShowOrderDetailsCubit, ShowOrderDetailsState>(
              builder: (context, state) {
                if (state is ShowOrderDetailsLoading) {
                  return OrderDetailsLoading();
                }
                if (state is ShowOrderDetailsError) {
                  return Center(
                    child: AppErrorWidget(
                      errorMessage: state.message,
                      onRetry: () {
                        context.read<ShowOrderDetailsCubit>().showOrderDetails(
                          widget.orderId,
                        );
                      },
                    ),
                  );
                }
                if (state is ShowOrderDetailsSuccess) {
                  return _buildOrderDetailsBody(state.orderDetailsData);
                }
                return SizedBox.shrink();
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildOrderDetailsBody(OrderDetailsData orderDetailsData) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.order_your_order_details.tr(),
              style: TextStyles.bold18.copyWith(color: AppColors.darkPrimary),
            ),
            AppSpacer(heightRatio: 0.3),
            Row(
              children: [
                Text(
                  " ${LocaleKeys.order_order_number.tr()} : ${orderDetailsData.serialNumber}",
                  style: TextStyles.bold16,
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.sp,
                    vertical: 10.sp,
                  ),
                  decoration: BoxDecoration(
                    color: orderDetailsData.status.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Center(
                    child: Text(
                      orderDetailsData.status.label,
                      style: TextStyles.bold14.copyWith(
                        color: orderDetailsData.status.color,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            AppSpacer(heightRatio: 1),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16.sp,
              children: orderDetailsData.products
                  .map((product) => OrderDetailsCardItem(item: product))
                  .toList(),
            ),
            // AppSpacer(heightRatio: 1),
            // BillDetailsCard(
            //   products:
            //       orderDetailsData.products
            //           .map((e) => ProductInfo.fromOrder(e))
            //           .toList(),
            //   total: orderDetailsData.total.toDouble(),
            // ),
          ],
        ),
      ),
    );
  }
}

class OrderDetailsLoading extends StatelessWidget {
  const OrderDetailsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerLoading(
              widget: ShimmerBox(
                height: 20.sp,
                width: 150.sp,
                borderRadius: 2.r,
              ),
            ),
            AppSpacer(heightRatio: 0.5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerLoading(
                  widget: ShimmerBox(
                    height: 20.sp,
                    width: 200.sp,
                    borderRadius: 2.r,
                  ),
                ),
                ShimmerLoading(
                  widget: ShimmerBox(
                    height: 40.sp,
                    width: 100,
                    borderRadius: 20.r,
                  ),
                ),
              ],
            ),
            AppSpacer(heightRatio: 1),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16.sp,
              children: List.generate(
                10,
                (_) => OrderDetailsCardShimmerLoading(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
