import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/util/token_storge_helper.dart';
import 'package:investhub_app/core/widgets/app_error_widget.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/core/widgets/cached_image.dart';
import 'package:investhub_app/core/widgets/shimmer_loading.dart';
import 'package:investhub_app/core/widgets/spinner_loading.dart';
import 'package:investhub_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:investhub_app/features/home/presentation/cubits/show_product/show_product_cubit.dart';
import 'package:investhub_app/features/home/presentation/widgets/visitor_popup_widget.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int productId;
  const ProductDetailsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = TokenStorageHelper.isLoggedIn;

    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.product_details.tr())),
      body: BlocProvider<ShowProductCubit>(
        create: (context) =>
            sl<ShowProductCubit>()..showProductEvent(productId: productId),
        child: BlocBuilder<ShowProductCubit, ShowProductState>(
          builder: (context, state) {
            if (state is ShowProductLoading) {
              return const ShowProductShimmer();
            }
            if (state is ShowProductError) {
              return Center(
                child: AppErrorWidget(
                  errorMessage: state.message,
                  onRetry: () {
                    context.read<ShowProductCubit>().showProductEvent(
                      productId: productId,
                    );
                  },
                ),
              );
            }
            if (state is ShowProductLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ShowProductCubit>().showProductEvent(
                    productId: productId,
                  );
                },
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CacheNetworkImage(
                        imageUrl: state.product.image,
                        height: 250.sp,
                        fit: BoxFit.fitHeight,
                      ),
                      AppSpacer(heightRatio: 1),
                      Text(state.product.name, style: TextStyles.regular18),
                      AppSpacer(heightRatio: 0.5),
                      // if (isLoggedIn) ...[
                      //   if (state.product.priceAfterDiscount != null) ...[
                      //     Row(
                      //       children: [
                      //         Text(
                      //           '${state.product.priceAfterDiscount} ${LocaleKeys.pound.tr()}',
                      //           style: TextStyles.bold22.copyWith(
                      //             color: AppColors.primary,
                      //           ),
                      //         ),
                      //         AppSpacer(widthRatio: 0.5),
                      //         Text(
                      //           '${state.product.price} ${LocaleKeys.pound.tr()}',
                      //           style: TextStyles.regular20.copyWith(
                      //             color: AppColors.greyHint,
                      //             decoration: TextDecoration.lineThrough,
                      //             decorationThickness: 30.sp,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ] else ...[
                      //     Text(
                      //       '${state.product.price} ${LocaleKeys.pound.tr()}',
                      //       style: TextStyles.bold22.copyWith(
                      //         color: AppColors.primary,
                      //       ),
                      //     ),
                      //   ],
                      // ],
                      AppSpacer(heightRatio: 0.5),
                      Divider(
                        thickness: 3.sp,
                        color: AppColors.unActiveBorderColor,
                      ),
                      AppSpacer(heightRatio: 0.5),
                      Text(
                        LocaleKeys.product_brand.tr(),
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
                        padding: EdgeInsets.all(16.sp),
                        child: Text(
                          state.product.brand,
                          style: TextStyles.regular16,
                        ),
                      ),
                      AppSpacer(heightRatio: 1),
                      Text(
                        '${LocaleKeys.product_details.tr()} :',
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
                          state.product.description,
                          style: TextStyles.regular16.copyWith(height: 1.8.sp),
                        ),
                      ),
                      AppSpacer(heightRatio: 2),
                      BlocBuilder<CartCubit, CartState>(
                        builder: (context, cartState) {
                          return Visibility(
                            visible: !cartState.requestStatus.isLoading,
                            replacement: const SpinnerLoading(),
                            child: ElevatedButton(
                              onPressed: () {
                                if (!isLoggedIn) {
                                  appNavigator.showDialog(
                                    child: VisitorPopupWidget(),
                                  );
                                } else {
                                  context.read<CartCubit>().addToCart(
                                    itemId: state.product.id,
                                    itemType: state.product.type,
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

class ShowProductShimmer extends StatelessWidget {
  const ShowProductShimmer({super.key});

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
            // Row(
            //   children: [
            //     ShimmerLoading(
            //       widget: Container(
            //         width: 90.sp,
            //         height: 15.sp,
            //         decoration: BoxDecoration(
            //           color: Colors.white,
            //           borderRadius: BorderRadius.circular(2.r),
            //         ),
            //       ),
            //     ),
            //     AppSpacer(widthRatio: 0.5),
            //     ShimmerLoading(
            //       widget: Container(
            //         width: 90.sp,
            //         height: 15.sp,
            //         decoration: BoxDecoration(
            //           color: Colors.white,
            //           borderRadius: BorderRadius.circular(2.r),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
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
                ShimmerLoading(
                  widget: Container(
                    width: double.infinity,
                    height: 150.sp,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
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
