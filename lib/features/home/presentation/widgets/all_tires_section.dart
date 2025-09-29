import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/enums/product_enum.dart';
import 'package:investhub_app/core/util/request_status.dart';
import 'package:investhub_app/core/widgets/app_error_widget.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/features/home/data/models/all_products_response.dart';
import 'package:investhub_app/features/home/presentation/cubits/all_products/all_tires_cubit.dart';
import 'package:investhub_app/features/home/presentation/widgets/product_card_item.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllTiresSection extends StatefulWidget {
  final AllTiresCubit allTiresCubit;
  const AllTiresSection({super.key, required this.allTiresCubit});

  @override
  State<AllTiresSection> createState() => _AllTiresSectionState();
}

class _AllTiresSectionState extends State<AllTiresSection> {
  @override
  void initState() {
    super.initState();
    widget.allTiresCubit
      ..clearFilter()
      ..setFilter(productType: ProductType.tires);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 241.sp,
      child: BlocSelector<AllTiresCubit, AllTiresState, RequestStatus>(
        selector: (state) {
          return state.allRequestStatus;
        },
        builder: (context, state) {
          if (state == RequestStatus.loading) {
            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              itemCount: 10,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => AppSpacer(widthRatio: 0.5),
              itemBuilder: (context, index) => ProductCardShimmer(),
            );
          }
          if (state == RequestStatus.error) {
            return BlocSelector<AllTiresCubit, AllTiresState, String>(
              selector: (state) {
                return state.generalErrorMessage;
              },
              builder: (context, state) {
                return AppErrorWidget(
                  errorMessage: state,
                  onRetry: () {
                    context.read<AllTiresCubit>().getTiresForFirstTime();
                  },
                );
              },
            );
          }
          if (state == RequestStatus.success) {
            return BlocSelector<AllTiresCubit, AllTiresState, List<Product>>(
              selector: (state) {
                return state.tires;
              },
              builder: (context, state) {
                if (state.isEmpty) {
                  return Center(
                    child: Text(
                      LocaleKeys.no_tires.tr(),
                      style: TextStyles.regular16,
                    ),
                  );
                }
                return ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16.sp),
                  itemCount: state.length,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) =>
                      AppSpacer(widthRatio: 0.5),
                  itemBuilder: (context, index) =>
                      ProductCardItem(product: state[index]),
                );
              },
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
