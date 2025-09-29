// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/util/request_status.dart';
import 'package:investhub_app/core/widgets/app_error_widget.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/features/home/data/models/all_departments_response.dart';
import 'package:investhub_app/features/home/presentation/cubits/all_departments/all_deparments_cubit.dart';
import 'package:investhub_app/features/home/presentation/widgets/department_card_item.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';

class AllDepartmentsSection extends StatefulWidget {
  final AllDeparmentsCubit allDeparmentsCubit;
  const AllDepartmentsSection({super.key, required this.allDeparmentsCubit});

  @override
  State<AllDepartmentsSection> createState() => _AllDepartmentsSectionState();
}

class _AllDepartmentsSectionState extends State<AllDepartmentsSection> {
  @override
  void initState() {
    super.initState();
    widget.allDeparmentsCubit.getDepartmentsForFirstTime();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130.sp,
      child:
          BlocSelector<AllDeparmentsCubit, AllDeparmentsState, RequestStatus>(
            selector: (state) {
              return state.allRequestStatus;
            },
            builder: (context, state) {
              if (state == RequestStatus.loading) {
                return DepartmentCardItemShimmer();
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
                          DepartmentCardItem(department: state[index]),
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
