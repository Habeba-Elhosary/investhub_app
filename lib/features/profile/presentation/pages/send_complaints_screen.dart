import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/util/validator.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/core/widgets/loading_button.dart';
import 'package:investhub_app/features/general/presentation/cubits/send_complaint/send_complaint_cubit.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendComplainScreen extends StatefulWidget {
  const SendComplainScreen({super.key});

  @override
  State<SendComplainScreen> createState() => _SendComplainScreenState();
}

class _SendComplainScreenState extends State<SendComplainScreen> {
  TextEditingController contentController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    contentController.dispose();
    _formKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.profile_complaintsAndSuggestions.tr()),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.sp),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset(AppAssets.imagesComplaint, height: 230.sp),
              const AppSpacer(heightRatio: 2),
              Text(
                LocaleKeys.profile_enter_your_complaint.tr(),
                style: TextStyles.bold18,
              ),
              const AppSpacer(heightRatio: 1),
              TextFormField(
                cursorColor: AppColors.primary,
                validator: (String? value) => Validator.defaultValidator(value),
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                controller: contentController,
                maxLines: 7,
                decoration: InputDecoration(
                  hintText: LocaleKeys
                      .profile_complaint_or_suggestion_placeholder
                      .tr(),
                ),
              ),
              const AppSpacer(heightRatio: 2),
              BlocProvider<SendComplaintCubit>(
                create: (context) => sl<SendComplaintCubit>(),
                child: Builder(
                  builder: (context) {
                    return LoadingButton<
                      SendComplaintCubit,
                      SendComplaintState,
                      SendComplainLoading
                    >(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<SendComplaintCubit>().sendComplainEvent(
                            contentController.text,
                          );
                        }
                      },
                      title: LocaleKeys.send.tr(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
