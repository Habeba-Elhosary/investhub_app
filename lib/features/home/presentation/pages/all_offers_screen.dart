import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/util/request_status.dart';
import 'package:investhub_app/core/widgets/app_error_widget.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/features/home/data/models/all_offers_response.dart';
import 'package:investhub_app/features/home/presentation/cubits/all_offers/all_offers_cubit.dart';
import 'package:investhub_app/features/home/presentation/widgets/offer_card_item.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AllOffersScreen extends StatelessWidget {
  const AllOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.offers.tr())),
      body: BlocProvider<AllOffersCubit>(
        create: (context) => sl<AllOffersCubit>()
          ..getOffersForFirstTime()
          ..initScoll(),
        child: BlocBuilder<AllOffersCubit, AllOffersState>(
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
                    controller: context.read<AllOffersCubit>().searchController,
                    onChanged: (String value) {
                      context.read<AllOffersCubit>().setFilter(
                        searchText: value,
                      );
                    },
                    onTapOutside: (PointerDownEvent event) {
                      FocusScope.of(context).unfocus();
                    },
                    decoration: InputDecoration(
                      hintText: LocaleKeys.search_offer.tr(),
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
                          .read<AllOffersCubit>()
                          .getOffersForFirstTime(),
                      child:
                          BlocSelector<
                            AllOffersCubit,
                            AllOffersState,
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
                                      .read<AllOffersCubit>()
                                      .scrollController,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.87,
                                        crossAxisSpacing: 12.sp,
                                        mainAxisSpacing: 12.sp,
                                      ),
                                  itemBuilder: (context, index) =>
                                      OfferCardShimmer(),
                                );
                              }
                              if (state == RequestStatus.error) {
                                return BlocSelector<
                                  AllOffersCubit,
                                  AllOffersState,
                                  String
                                >(
                                  selector: (state) {
                                    return state.generalErrorMessage;
                                  },
                                  builder: (context, state) {
                                    return AppErrorWidget(
                                      onRetry: () {
                                        context
                                            .read<AllOffersCubit>()
                                            .getOffersForFirstTime();
                                      },
                                      errorMessage: state,
                                    );
                                  },
                                );
                              }
                              if (state == RequestStatus.success) {
                                return BlocSelector<
                                  AllOffersCubit,
                                  AllOffersState,
                                  List<OfferSummary>
                                >(
                                  selector: (state) {
                                    return state.offers;
                                  },
                                  builder: (context, state) {
                                    if (state.isEmpty) {
                                      return Center(
                                        child: Text(
                                          LocaleKeys.no_offers_message.tr(),
                                        ),
                                      );
                                    }
                                    return GridView.builder(
                                      itemCount: state.length,
                                      controller: context
                                          .read<AllOffersCubit>()
                                          .scrollController,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 0.87,
                                            crossAxisSpacing: 12.sp,
                                            mainAxisSpacing: 12.sp,
                                          ),
                                      itemBuilder: (context, index) =>
                                          OfferCardItem(offer: state[index]),
                                    );
                                  },
                                );
                              }
                              return SizedBox.shrink();
                            },
                          ),
                    ),
                  ),
                  BlocSelector<AllOffersCubit, AllOffersState, RequestStatus>(
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
                                AllOffersCubit,
                                AllOffersState,
                                String
                              >(
                                selector: (pState) {
                                  return pState.paginationErrorMessage;
                                },
                                builder: (BuildContext context, String state) {
                                  return AppErrorWidget(
                                    onRetry: () {
                                      context
                                          .read<AllOffersCubit>()
                                          .loadMoreOffers();
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
