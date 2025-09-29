import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/enums/item_enum.dart';
import 'package:investhub_app/core/util/token_storge_helper.dart';
import 'package:investhub_app/core/widgets/app_error_widget.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/core/widgets/cached_image.dart';
import 'package:investhub_app/core/widgets/shimmer_loading.dart';
import 'package:investhub_app/core/widgets/spinner_loading.dart';
import 'package:investhub_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:investhub_app/features/home/presentation/cubits/show_offer/show_offer_cubit.dart';
import 'package:investhub_app/features/home/presentation/widgets/visitor_popup_widget.dart';
import 'package:investhub_app/features/orders/presentation/widgets/order_details_card_item.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class OfferDetailsScreen extends StatelessWidget {
  final int offerId;
  const OfferDetailsScreen({super.key, required this.offerId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.offer_details.tr())),
      body: BlocProvider<ShowOfferCubit>(
        create: (context) =>
            sl<ShowOfferCubit>()..showOfferEvent(offerId: offerId),
        child: BlocBuilder<ShowOfferCubit, ShowOfferState>(
          builder: (context, state) {
            if (state is ShowOfferLoading) {
              return const ShowOfferShimmer();
            }
            if (state is ShowOfferError) {
              return Center(
                child: AppErrorWidget(
                  errorMessage: state.message,
                  onRetry: () {
                    context.read<ShowOfferCubit>().showOfferEvent(
                      offerId: offerId,
                    );
                  },
                ),
              );
            }
            if (state is ShowOfferLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ShowOfferCubit>().showOfferEvent(
                    offerId: offerId,
                  );
                },
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CacheNetworkImage(
                        imageUrl: state.offer.image,
                        height: 250.sp,
                        fit: BoxFit.fitHeight,
                      ),
                      AppSpacer(heightRatio: 1),
                      Text(state.offer.title, style: TextStyles.regular18),
                      AppSpacer(heightRatio: 0.5),
                      Divider(
                        thickness: 3.sp,
                        color: AppColors.unActiveBorderColor,
                      ),
                      AppSpacer(heightRatio: 0.5),
                      Text(
                        LocaleKeys.offer_description.tr(),
                        style: TextStyles.bold16,
                      ),
                      AppSpacer(heightRatio: 0.5),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: AppColors.unActiveBorderColor.withOpacity(
                              0.4,
                            ),
                          ),
                        ),
                        padding: EdgeInsets.all(16.0.sp),
                        child: Text(
                          state.offer.description,
                          style: TextStyles.regular16.copyWith(height: 1.8.sp),
                        ),
                      ),
                      AppSpacer(heightRatio: 0.5),
                      Text(
                        LocaleKeys.offer_products.tr(),
                        style: TextStyles.bold16,
                      ),
                      AppSpacer(heightRatio: 0.5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 16.sp,
                        children: state.offer.products
                            .map(
                              (product) => OrderDetailsCardItem(item: product),
                            )
                            .toList(),
                      ),
                      AppSpacer(heightRatio: 2),
                      BlocBuilder<CartCubit, CartState>(
                        builder: (context, cartState) {
                          return Visibility(
                            visible: !cartState.requestStatus.isLoading,
                            replacement: const SpinnerLoading(),
                            child: ElevatedButton(
                              onPressed: () async {
                                final bool isLoggedIn =
                                    await TokenStorageHelper.hasValidToken();

                                if (!isLoggedIn) {
                                  appNavigator.showDialog(
                                    child: VisitorPopupWidget(),
                                  );
                                } else {
                                  // ignore: use_build_context_synchronously
                                  context.read<CartCubit>().addToCart(
                                    itemId: state.offer.id,
                                    itemType: ItemType.offer,
                                  );
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppAssets.imagesCart,
                                    height: 22.sp,
                                    colorFilter: ColorFilter.mode(
                                      Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  AppSpacer(widthRatio: 0.6),
                                  Text(LocaleKeys.add_to_cart.tr()),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class ShowOfferShimmer extends StatelessWidget {
  const ShowOfferShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ShimmerLoading(
              widget: Container(
                width: double.infinity,
                height: 250.sp,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
            ),
            AppSpacer(heightRatio: 1),
            Row(
              children: [
                ShimmerLoading(
                  widget: Container(
                    width: 150.sp,
                    height: 15.sp,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
              ],
            ),
            AppSpacer(heightRatio: 0.5),
            ShimmerLoading(
              widget: Divider(thickness: 3.sp, color: AppColors.white),
            ),
            AppSpacer(heightRatio: 0.5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerLoading(
                  widget: Container(
                    width: 150.sp,
                    height: 15.sp,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                AppSpacer(heightRatio: 0.5),
                ShimmerLoading(
                  widget: Container(
                    width: double.infinity,
                    height: 70.sp,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  ),
                ),
                AppSpacer(heightRatio: 1),
                ShimmerLoading(
                  widget: Container(
                    width: 150.sp,
                    height: 15.sp,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                AppSpacer(heightRatio: 0.5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16.sp,
                  children: List.generate(
                    5,
                    (_) => OrderDetailsCardShimmerLoading(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
