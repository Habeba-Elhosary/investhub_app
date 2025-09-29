import 'package:investhub_app/core/enums/static_data_enum.dart';
import 'package:investhub_app/core/widgets/app_error_widget.dart';
import 'package:investhub_app/core/widgets/spinner_loading.dart';
import 'package:investhub_app/features/general/presentation/cubits/static_data/static_data_cubit.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/constant/values/colors.dart';

class ContactBottomSheet extends StatelessWidget {
  const ContactBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(LocaleKeys.whats_up.tr()),
                    onTap: () async {
                      final Uri phoneCallURI = Uri.parse(
                        'whatsapp://send?phone=${state.data.replaceFirst('0', '+20')}&text=${LocaleKeys.contact_message.tr()}',
                      );
                      if (!await launchUrl(
                        phoneCallURI,
                        mode: LaunchMode.externalApplication,
                      )) {
                        throw Exception('Could not launch $phoneCallURI');
                      }
                    },
                    leading: const FaIcon(
                      FontAwesomeIcons.whatsapp,
                      color: AppColors.primary,
                    ),
                  ),
                  ListTile(
                    title: Text(LocaleKeys.call.tr()),
                    onTap: () async {
                      final Uri phoneCallURI = Uri.parse(
                        'tel://${state.data.replaceFirst('0', '+20')}',
                      );
                      if (!await launchUrl(
                        phoneCallURI,
                        mode: LaunchMode.externalApplication,
                      )) {
                        throw Exception('Could not launch $phoneCallURI');
                      }
                    },
                    leading: const Icon(Icons.call, color: AppColors.primary),
                  ),
                  ListTile(
                    title: Text(LocaleKeys.sms.tr()),
                    onTap: () async {
                      final Uri phoneCallURI = Uri.parse(
                        'sms:${state.data.replaceFirst('0', '+20')}?body=${LocaleKeys.contact_message.tr()}',
                      );
                      if (!await launchUrl(
                        phoneCallURI,
                        mode: LaunchMode.externalApplication,
                      )) {
                        throw Exception('Could not launch $phoneCallURI');
                      }
                    },
                    leading: const Icon(Icons.sms, color: AppColors.primary),
                  ),
                  ListTile(
                    title: Text(LocaleKeys.copy.tr()),
                    onTap: () async {
                      Clipboard.setData(
                        ClipboardData(
                          text: state.data.replaceFirst('0', '+20'),
                        ),
                      ).then((_) {
                        Fluttertoast.showToast(msg: tr('copied'));
                      });
                    },
                    leading: const FaIcon(Icons.copy, color: AppColors.primary),
                  ),
                ],
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
