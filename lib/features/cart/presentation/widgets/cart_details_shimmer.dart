import 'package:investhub_app/features/cart/presentation/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartDetailsShimmer extends StatelessWidget {
  const CartDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16.sp),
      itemCount: 10,
      itemBuilder: (context, index) => CartItemShimmer(),
    );
  }
}
