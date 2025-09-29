import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/util/request_status.dart';
import 'package:investhub_app/core/widgets/app_error_widget.dart';
import 'package:investhub_app/features/notifications/domain/entities/notification_response.dart';
import 'package:investhub_app/features/notifications/presentation/cubits/all_notification/all_notification_cubit.dart';
import 'package:investhub_app/features/notifications/presentation/widgets/mark_as_read_button.dart';
import 'package:investhub_app/features/notifications/presentation/widgets/notification_card.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    sl<AllNotificationsCubit>().initScoll();
    sl<AllNotificationsCubit>().getNotificationsForFirstTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.notifications_the_notifications.tr()),
        actions: [MakeAllNotificationReadButton()],
      ),
      body: BlocBuilder<AllNotificationsCubit, AllNotificationsState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  color: AppColors.primary,
                  onRefresh: () async {
                    context
                        .read<AllNotificationsCubit>()
                        .getNotificationsForFirstTime();
                  },
                  child:
                      BlocSelector<
                        AllNotificationsCubit,
                        AllNotificationsState,
                        RequestStatus
                      >(
                        selector: (state) => state.allRequestStatus,
                        builder: (context, state) {
                          if (state == RequestStatus.loading) {
                            return ListView.builder(
                              padding: EdgeInsets.all(16.sp),
                              itemCount: 10,
                              itemBuilder: (context, index) =>
                                  NotificationCardShimmer(),
                            );
                          }
                          if (state == RequestStatus.error) {
                            return BlocSelector<
                              AllNotificationsCubit,
                              AllNotificationsState,
                              String
                            >(
                              selector: (state) {
                                return state.generalErrorMessage;
                              },
                              builder: (context, state) {
                                return Center(
                                  child: AppErrorWidget(
                                    errorMessage: state,
                                    onRetry: () {
                                      context
                                          .read<AllNotificationsCubit>()
                                          .getNotificationsForFirstTime();
                                    },
                                  ),
                                );
                              },
                            );
                          }
                          if (state == RequestStatus.success) {
                            return BlocSelector<
                              AllNotificationsCubit,
                              AllNotificationsState,
                              List<NotificationEntity>
                            >(
                              selector: (state) => state.notifications,
                              builder: (context, state) {
                                if (state.isEmpty) {
                                  return Center(
                                    child: Text(
                                      LocaleKeys.notifications_no_notifications
                                          .tr(),
                                    ),
                                  );
                                }
                                return ListView.builder(
                                  controller: context
                                      .read<AllNotificationsCubit>()
                                      .scrollController,
                                  padding: EdgeInsets.all(14.sp),
                                  itemCount: state.length,
                                  itemBuilder: (context, index) =>
                                      NotificationCard(
                                        notification: state[index],
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
                AllNotificationsCubit,
                AllNotificationsState,
                RequestStatus
              >(
                selector: (pState) {
                  return pState.paginationRequestStatus;
                },
                builder: (BuildContext context, RequestStatus state) {
                  if (state == RequestStatus.loading) {
                    return Center(child: CircularProgressIndicator.adaptive());
                  }
                  if (state == RequestStatus.error) {
                    return Center(
                      child:
                          BlocSelector<
                            AllNotificationsCubit,
                            AllNotificationsState,
                            String
                          >(
                            selector: (pState) {
                              return pState.paginationErrorMessage;
                            },
                            builder: (BuildContext context, String state) {
                              return AppErrorWidget(
                                onRetry: () {
                                  context
                                      .read<AllNotificationsCubit>()
                                      .loadMoreNotifications();
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
    );
  }
}
