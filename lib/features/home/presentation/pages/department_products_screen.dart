import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/util/request_status.dart';
import 'package:investhub_app/core/widgets/app_error_widget.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/features/home/data/models/all_departments_response.dart';
import 'package:investhub_app/features/home/data/models/all_products_response.dart';
import 'package:investhub_app/features/home/presentation/cubits/department_products/department_products_cubit.dart';
import 'package:investhub_app/features/home/presentation/widgets/product_card_item.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DepartmentProductsScreen extends StatelessWidget {
  final Department department;

  const DepartmentProductsScreen({super.key, required this.department});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(department.name)),
      body: BlocProvider<DepartmentProductsCubit>(
        create: (context) => sl<DepartmentProductsCubit>()
          ..setFilter(departmentId: department.id)
          ..initScoll(),
        child: BlocBuilder<DepartmentProductsCubit, DepartmentProductsState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16.sp,
                right: 16.sp,
                bottom: 16.sp,
              ),
              child: Column(
                children: [
                  TextFormField(
                    controller: context
                        .read<DepartmentProductsCubit>()
                        .searchController,
                    onChanged: (String value) {
                      context.read<DepartmentProductsCubit>().setFilter(
                        searchText: value,
                      );
                    },
                    onTapOutside: (PointerDownEvent event) {
                      FocusScope.of(context).unfocus();
                    },
                    decoration: InputDecoration(
                      hintText: LocaleKeys.search_product.tr(),
                      prefixIcon: SvgPicture.asset(
                        AppAssets.imagesSearch,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  AppSpacer(heightRatio: 0.5),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => context
                          .read<DepartmentProductsCubit>()
                          .getDepartmentProductsForFirstTime(),
                      child:
                          BlocSelector<
                            DepartmentProductsCubit,
                            DepartmentProductsState,
                            RequestStatus
                          >(
                            selector: (state) {
                              return state.allRequestStatus;
                            },
                            builder: (context, state) {
                              if (state == RequestStatus.loading) {
                                return GridView.builder(
                                  itemCount: 14,
                                  controller: context
                                      .read<DepartmentProductsCubit>()
                                      .scrollController,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.87,
                                        crossAxisSpacing: 12.sp,
                                        mainAxisSpacing: 12.sp,
                                      ),
                                  itemBuilder: (context, index) =>
                                      ProductCardShimmer(),
                                );
                              }
                              if (state == RequestStatus.error) {
                                return BlocSelector<
                                  DepartmentProductsCubit,
                                  DepartmentProductsState,
                                  String
                                >(
                                  selector: (state) {
                                    return state.generalErrorMessage;
                                  },
                                  builder: (context, state) {
                                    return AppErrorWidget(
                                      onRetry: () {
                                        context
                                            .read<DepartmentProductsCubit>()
                                            .getDepartmentProductsForFirstTime();
                                      },
                                      errorMessage: state,
                                    );
                                  },
                                );
                              }
                              if (state == RequestStatus.success) {
                                return BlocSelector<
                                  DepartmentProductsCubit,
                                  DepartmentProductsState,
                                  List<Product>
                                >(
                                  selector: (state) {
                                    return state.products;
                                  },
                                  builder: (context, state) {
                                    if (state.isEmpty) {
                                      return Center(
                                        child: Text(
                                          LocaleKeys.no_products.tr(),
                                        ),
                                      );
                                    }
                                    return GridView.builder(
                                      itemCount: state.length,
                                      controller: context
                                          .read<DepartmentProductsCubit>()
                                          .scrollController,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 0.87,
                                            crossAxisSpacing: 12.sp,
                                            mainAxisSpacing: 12.sp,
                                          ),
                                      itemBuilder: (context, index) =>
                                          ProductCardItem(
                                            product: state[index],
                                          ),
                                    );
                                  },
                                );
                              }
                              return SizedBox.shrink();
                            },
                          ),
                    ),
                  ),
                  BlocSelector<
                    DepartmentProductsCubit,
                    DepartmentProductsState,
                    RequestStatus
                  >(
                    selector: (pState) {
                      return pState.paginationRequestStatus;
                    },
                    builder: (BuildContext context, RequestStatus state) {
                      if (state == RequestStatus.loading) {
                        return Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                      if (state == RequestStatus.error) {
                        return Center(
                          child:
                              BlocSelector<
                                DepartmentProductsCubit,
                                DepartmentProductsState,
                                String
                              >(
                                selector: (pState) {
                                  return pState.paginationErrorMessage;
                                },
                                builder: (BuildContext context, String state) {
                                  return AppErrorWidget(
                                    onRetry: () {
                                      context
                                          .read<DepartmentProductsCubit>()
                                          .loadMoreProducts();
                                    },
                                    errorMessage: state,
                                  );
                                },
                              ),
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
