// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/features/auth/presentation/cubits/register/register_cubit.dart';
import 'package:investhub_app/features/general/presentation/cubits/registration_questions/registration_questions_cubit.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';

class RegisterFormThree extends StatefulWidget {
  final RegisterCubit registerCubit;
  const RegisterFormThree({super.key, required this.registerCubit});

  @override
  State<RegisterFormThree> createState() => _RegisterFormThreeState();
}

class _RegisterFormThreeState extends State<RegisterFormThree> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<RegistrationQuestionsCubit>();
    if (cubit.state is! RegistrationQuestionsLoaded) {
      cubit.getRegistrationQuestions();
    }
  }

  @override
  Widget build(BuildContext context) {
    final registerCubit = widget.registerCubit;

    return BlocBuilder<RegistrationQuestionsCubit, RegistrationQuestionsState>(
      builder: (context, state) {
        if (state is RegistrationQuestionsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is RegistrationQuestionsError) {
          return Center(child: Text(state.message));
        }

        if (state is RegistrationQuestionsLoaded) {
          final questions = state.questions;

          return Form(
            key: registerCubit.formKeyStep3,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final question = questions[index];

                // ✅ هنا نجيب الإجابة المحفوظة من الكيوبت لو موجودة
                final savedAnswer = registerCubit.answers.firstWhere(
                  (element) => element['question_id'] == question.id,
                  orElse: () => {},
                );

                if (savedAnswer.isNotEmpty) {
                  question.answer = savedAnswer['answer'];
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(question.question, style: TextStyles.regular18),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text(LocaleKeys.yes.tr()),
                            value: "yes",
                            groupValue: question.answer,
                            activeColor: AppColors.primary,
                            onChanged: (value) {
                              if (value == null) return;
                              setState(() {
                                question.answer = value;
                              });
                              registerCubit.updateAnswer(question.id, value);
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text(LocaleKeys.no.tr()),
                            value: "no",
                            groupValue: question.answer,
                            activeColor: AppColors.primary,
                            onChanged: (value) {
                              if (value == null) return;
                              setState(() {
                                question.answer = value;
                              });
                              registerCubit.updateAnswer(question.id, value);
                            },
                          ),
                        ),
                      ],
                    ),
                    if (index != questions.length - 1)
                      AppSpacer(heightRatio: 0.5),
                  ],
                );
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
