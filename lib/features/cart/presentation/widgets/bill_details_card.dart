// import 'package:investhub_app/core/constant/values/colors.dart';
// import 'package:investhub_app/core/constant/values/text_styles.dart';
// import 'package:investhub_app/core/widgets/app_spacer.dart';
// import 'package:investhub_app/features/cart/domain/entities/product_info.dart';
// import 'package:investhub_app/generated/LocaleKeys.g.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class BillDetailsCard extends StatelessWidget {
//   const BillDetailsCard({
//     super.key,
//     required this.products,
//     required this.total,
//   });

//   final List<ProductInfo> products;
//   final double total;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(15.sp),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10.r),
//         border: Border.all(color: AppColors.unActiveBorderColor),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(LocaleKeys.bill_details.tr(), style: TextStyles.bold18),
//           AppSpacer(heightRatio: 0.3),
//           Divider(thickness: 1.sp, color: AppColors.unActiveBorderColor),
//           AppSpacer(heightRatio: 0.3),
//           Column(
//             spacing: 12.sp,
//             children:
//                 products.map((item) {
//                   return Row(
//                     children: [
//                       Text('(${item.quantity})', style: TextStyles.regular16),
//                       AppSpacer(widthRatio: 0.5),
//                       Text(
//                         item.name,
//                         style: TextStyles.regular16.copyWith(
//                           color: AppColors.greyHint,
//                         ),
//                       ),
//                       Spacer(),
//                       if (item.priceAfterDiscount != null) ...[
//                         Text(
//                           '${item.priceAfterDiscount} ${LocaleKeys.pound.tr()}',
//                           style: TextStyles.bold16,
//                         ),
//                       ] else ...[
//                         Text(
//                           '${item.price} ${LocaleKeys.pound.tr()}',
//                           style: TextStyles.bold16,
//                         ),
//                       ],
//                     ],
//                   );
//                 }).toList(),
//           ),
//           AppSpacer(heightRatio: 0.3),
//           Divider(thickness: 1.sp, color: AppColors.unActiveBorderColor),
//           AppSpacer(heightRatio: 0.3),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(LocaleKeys.total.tr(), style: TextStyles.bold16),
//               const Spacer(),
//               Text('$total ${LocaleKeys.pound.tr()}', style: TextStyles.bold18),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
