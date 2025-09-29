import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/enums/static_data_enum.dart';
import 'package:investhub_app/core/widgets/app_error_widget.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/core/widgets/spinner_loading.dart';
import 'package:investhub_app/features/general/presentation/cubits/static_data/static_data_cubit.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class CallCenterBottomSeet extends StatelessWidget {
  const CallCenterBottomSeet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.sp),
      child: BlocProvider<StaticDataCubit>(
        create: (context) => sl<StaticDataCubit>()
          ..getStaticDataEvent(getStaticDataTypeString(StaticDataType.phone)),
        child: BlocBuilder<StaticDataCubit, StaticDataState>(
          builder: (context, state) {
            if (state is StaticDataLoading) {
              return const SpinnerLoading();
            }
            if (state is StaticDataError) {
              return AppErrorWidget(
                errorMessage: state.message,
                onRetry: () {
                  context.read<StaticDataCubit>().getStaticDataEvent(
                    getStaticDataTypeString(StaticDataType.phone),
                  );
                },
              );
            }
            if (state is StaticDataLoaded) {
              final phone = state.data.replaceFirst('0', '+20');

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Image.asset(AppAssets.imagesCallCenter, height: 150.sp),
                  const AppSpacer(heightRatio: 1),
                  Text(
                    LocaleKeys.choose_contact_method.tr(),
                    style: TextStyles.bold16.copyWith(color: AppColors.black),
                  ),
                  const AppSpacer(heightRatio: 0.5),
                  Text(
                    LocaleKeys.choose_contact_subtitle.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyles.regular14.copyWith(
                      color: AppColors.greyDark,
                    ),
                  ),
                  const AppSpacer(heightRatio: 1.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final Uri whatsappUri = Uri.parse(
                              'whatsapp://send?phone=$phone&text=${LocaleKeys.contact_message.tr()}',
                            );
                            if (!await launchUrl(
                              whatsappUri,
                              mode: LaunchMode.externalApplication,
                            )) {
                              throw Exception('Could not launch $whatsappUri');
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.grey,
                            ),
                            child: Column(
                              children: [
                                // SvgPicture.asset(
                                //   AppAssets.imagesWhatsapp,
                                //   height: 30,
                                // ),
                                const SizedBox(height: 8),
                                Text(
                                  LocaleKeys.whatsapp.tr(),
                                  style: TextStyles.bold14.copyWith(
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const AppSpacer(widthRatio: 2),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final Uri phoneUri = Uri.parse('tel://$phone');
                            if (!await launchUrl(
                              phoneUri,
                              mode: LaunchMode.externalApplication,
                            )) {
                              throw Exception('Could not launch $phoneUri');
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: AppColors.grey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Icon(Icons.call, color: Colors.blue, size: 30),
                                const SizedBox(height: 8),
                                Text(
                                  LocaleKeys.call.tr(),
                                  style: TextStyles.bold14.copyWith(
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
