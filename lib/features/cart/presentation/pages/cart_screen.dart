import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/widgets/app_error_widget.dart';
import 'package:investhub_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:investhub_app/features/cart/presentation/widgets/cart_details_shimmer.dart';
import 'package:investhub_app/features/cart/presentation/widgets/create_order_button.dart';
import 'package:investhub_app/features/cart/presentation/widgets/empty_cart_view.dart';
import 'package:investhub_app/features/cart/presentation/widgets/cart_item.dart';
import 'package:investhub_app/features/home/presentation/pages/product_details_screen.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().showCart();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(title: Text(LocaleKeys.cart_the_cart.tr())),
          body: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state.requestStatus.isLoading) {
                return CartDetailsShimmer();
              }
              if (state.requestStatus.isError) {
                return Center(
                  child: AppErrorWidget(
                    errorMessage: state.errorMessage,
                    onRetry: () {
                      context.read<CartCubit>().showCart();
                    },
                  ),
                );
              }
              if (state.requestStatus.isSuccess) {
                if (state.items.isEmpty) {
                  return EmptyCartView();
                }
                return buildSuccess(state);
              }
              return SizedBox.shrink();
            },
          ),
          bottomNavigationBar: CartOrderButton(),
        );
      },
    );
  }

  Widget buildSuccess(CartState state) {
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => context.read<CartCubit>().showCart(),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      appNavigator.push(
                        screen: ProductDetailsScreen(
                          productId: state.items[index].itemId,
                        ),
                      );
                    },
                    child: CartItem(cartItem: state.items[index]),
                  );
                },
              ),
              // AppSpacer(heightRatio: 1),
              // BillDetailsCard(
              //   products:
              //       state.items.map((e) => ProductInfo.fromCart(e)).toList(),
              //   total: state.totalItems.toDouble(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
