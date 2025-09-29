import 'package:investhub_app/core/widgets/loading_button.dart';
import 'package:investhub_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:investhub_app/features/orders/presentation/cubits/create_order/create_order_cubit.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartOrderButton extends StatelessWidget {
  const CartOrderButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final showButton =
            state.requestStatus.isSuccess && state.items.isNotEmpty;
        if (!showButton) return const SizedBox.shrink();
        return BlocProvider<CreateOrderCubit>(
          create: (context) => sl<CreateOrderCubit>(),
          child: BlocBuilder<CreateOrderCubit, CreateOrderState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: 30.sp,
                  left: 16.sp,
                  right: 16.sp,
                ),
                child:
                    LoadingButton<
                      CreateOrderCubit,
                      CreateOrderState,
                      CreateOrderLoading
                    >(
                      onTap: () {
                        context.read<CreateOrderCubit>().createOrderEvent();
                      },
                      title: LocaleKeys.cart_send_order.tr(),
                    ),
              );
            },
          ),
        );
      },
    );
  }
}
