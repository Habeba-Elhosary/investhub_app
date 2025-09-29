import 'package:investhub_app/core/widgets/spinner_loading.dart';
import 'package:investhub_app/features/auth/presentation/cubits/send_otp/send_otp_cubit.dart';
import 'package:investhub_app/features/auth/presentation/cubits/verification_code/verification_code_cubit.dart';
import 'package:investhub_app/features/auth/presentation/pages/verify_otp/verify_otp__timer_stream.dart';
import 'package:investhub_app/features/auth/presentation/widgets/auth_header.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:easy_localization/easy_localization.dart' as e;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../../../core/constant/values/colors.dart';
import '../../../../../../core/constant/values/size_config.dart';
import '../../../../../../core/constant/values/text_styles.dart';
import '../../../../../../core/widgets/app_spacer.dart';

class OTPVerficationScreen extends StatefulWidget {
  const OTPVerficationScreen({super.key});

  @override
  State<OTPVerficationScreen> createState() => _OTPVerficationScreenState();
}

class _OTPVerficationScreenState extends State<OTPVerficationScreen> {
  late TextEditingController otpController;

  @override
  void dispose() {
    // otpController.dispose();
    VerificationCodeTimerStream.stopTimer();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
    VerificationCodeTimerStream.counterValue = 60;
    VerificationCodeTimerStream.autoDecrement();
    VerificationCodeTimerStream.listen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider<SendOtpCubit>(
        create: (context) => sl<SendOtpCubit>(),
        child: Builder(
          builder: (context) {
            return SingleChildScrollView(
              child: Padding(
                padding: SizeConfig.paddingSymmetric,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    AuthHeader(
                      title: LocaleKeys.auth_confirm_identity.tr(),
                      subtitle: LocaleKeys.auth_confirm_identity_message.tr(),
                    ),
                    const AppSpacer(heightRatio: 1.5),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.sp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            color: AppColors.white,
                          ),
                          child: PinCodeTextField(
                            autoFocus: true,
                            controller: otpController,
                            appContext: context,
                            length: 6,
                            autoDisposeControllers: true,
                            cursorColor: AppColors.primary,
                            backgroundColor: Colors.white,
                            keyboardType: TextInputType.number,
                            textStyle: TextStyles.regular24,
                            pinTheme: PinTheme(
                              fieldOuterPadding: EdgeInsets.zero,
                              fieldHeight: 55.h,
                              fieldWidth: 50.w,
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(8.r),
                              activeColor: AppColors.primary,
                              inactiveColor: AppColors.unActiveBorderColor,
                              selectedColor: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const AppSpacer(heightRatio: 1),
                    BlocProvider(
                      create: (context) => sl<VerfiyCodeCubit>(),
                      child: Builder(
                        builder: (context) {
                          return BlocBuilder<VerfiyCodeCubit, VerfiyCodeState>(
                            builder: (context, state) {
                              return Visibility(
                                visible: state is! VerfiyCodeLoading,
                                replacement: const Center(
                                  child: SpinnerLoading(),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    context
                                        .read<VerfiyCodeCubit>()
                                        .verfiyCodeEvent(
                                          code: otpController.text,
                                        );
                                  },
                                  child: Text(
                                    LocaleKeys.confirm.tr(),
                                    style: TextStyles.bold16,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const AppSpacer(heightRatio: 1),
                    StreamBuilder<int>(
                      stream: VerificationCodeTimerStream.stream,
                      builder:
                          (BuildContext context, AsyncSnapshot<int> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data == 0) {
                                return Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        LocaleKeys.auth_didnt_receive_code.tr(),
                                        style: TextStyles.bold14,
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                        ),
                                        onPressed: () {
                                          context
                                              .read<SendOtpCubit>()
                                              .sendOTPEvent();
                                        },
                                        child: Text(
                                          LocaleKeys.auth_resend.tr(),
                                          style: TextStyles.bold14,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Column(
                                  children: [
                                    const AppSpacer(heightRatio: 1.3),
                                    Center(
                                      child: Text(
                                        VerificationCodeTimerStream.formatCounter(
                                          snapshot.data ?? 0,
                                        ),
                                        style: TextStyles.regular16.copyWith(
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
