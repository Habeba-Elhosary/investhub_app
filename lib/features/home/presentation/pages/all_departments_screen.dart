import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/util/request_status.dart';
import 'package:investhub_app/core/widgets/app_error_widget.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/features/home/data/models/all_departments_response.dart';
import 'package:investhub_app/features/home/presentation/cubits/all_departments/all_deparments_cubit.dart';
import 'package:investhub_app/features/home/presentation/widgets/department_tile_item.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AllDepartmentsScreen extends StatelessWidget {
  const AllDepartmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.home_all_categories.tr())),
      body: Padding(
        padding: EdgeInsets.only(left: 16.sp, right: 16.sp, bottom: 16.sp),
        child: BlocProvider<AllDeparmentsCubit>(
          create: (context) => sl<AllDeparmentsCubit>()
            ..clearFilter()
            ..initScoll(),
          child: BlocBuilder<AllDeparmentsCubit, AllDeparmentsState>(
            builder: (context, state) {
              return Column(
                children: [
                  TextFormField(
                    controller: context
                        .read<AllDeparmentsCubit>()
                        .searchController,
                    onChanged: (String value) {
                      context.read<AllDeparmentsCubit>().setFilter(
                        searchText: value,
                      );
                    },
                    onTapOutside: (PointerDownEvent event) {
                      FocusScope.of(context).unfocus();
                    },
                    decoration: InputDecoration(
                      hintText: LocaleKeys.home_search_category.tr(),
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
                          .read<AllDeparmentsCubit>()
                          .getDepartmentsForFirstTime(),
                      child:
                          BlocSelector<
                            AllDeparmentsCubit,
                            AllDeparmentsState,
                            RequestStatus
                          >(
                            selector: (state) {
                              return state.allRequestStatus;
                            },
                            builder: (context, state) {
                              if (state == RequestStatus.loading) {
                                return DepartmentTileShimmer();
                              }
                              if (state == RequestStatus.error) {
                                return BlocSelector<
                                  AllDeparmentsCubit,
                                  AllDeparmentsState,
                                  String
                                >(
                                  selector: (state) {
                                    return state.generalErrorMessage;
                                  },
                                  builder: (context, state) {
                                    return AppErrorWidget(
                                      onRetry: () {
                                        context
                                            .read<AllDeparmentsCubit>()
                                            .getDepartmentsForFirstTime();
                                      },
                                      errorMessage: state,
                                    );
                                  },
                                );
                              }
                              if (state == RequestStatus.success) {
                                return BlocSelector<
                                  AllDeparmentsCubit,
                                  AllDeparmentsState,
                                  List<Department>
                                >(
                                  selector: (state) {
                                    return state.departments;
                                  },
                                  builder: (context, state) {
                                    if (state.isEmpty) {
                                      return Center(
                                        child: Text(
                                          LocaleKeys.no_departments.tr(),
                                        ),
                                      );
                                    }
                                    return ListView.separated(
                                      controller: context
                                          .read<AllDeparmentsCubit>()
                                          .scrollController,
                                      itemCount: state.length,
                                      separatorBuilder: (context, index) =>
                                          AppSpacer(heightRatio: 0.4),
                                      itemBuilder: (context, index) =>
                                          DepartmentTileItem(
                                            department: state[index],
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
                    AllDeparmentsCubit,
                    AllDeparmentsState,
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
                                AllDeparmentsCubit,
                                AllDeparmentsState,
                                String
                              >(
                                selector: (pState) {
                                  return pState.paginationErrorMessage;
                                },
                                builder: (BuildContext context, String state) {
                                  return AppErrorWidget(
                                    onRetry: () {
                                      context
                                          .read<AllDeparmentsCubit>()
                                          .loadMoreDepartments();
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
          ),
        ),
      ),
    );
  }
}
