// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/features/auth/presentation/cubits/register/register_cubit.dart';

class RegisterFormThree extends StatefulWidget {
  final RegisterCubit registerCubit;
  const RegisterFormThree({super.key, required this.registerCubit});

  @override
  State<RegisterFormThree> createState() => _RegisterFormThreeState();
}

class _RegisterFormThreeState extends State<RegisterFormThree> {
  final List<Question> questions = [
    Question(text: 'هل لديك خبرة سابقة في الاستثمار بالأسهم ؟'),
    Question(text: 'هل أنت مستعد للمخاطرة بخسارة جزء من رأس المال ؟'),
    Question(text: 'هل لديك مصدر دخل ثابت لتغطية نفقاتك الأساسية ؟'),
    Question(text: 'هل تخطط لسحب أموالك المستثمرة في غضون 1-3 سنوات ؟'),
    Question(
      text: 'هل تفضل الاستثمارات ذات العوائد المرتفعة والمخاطر العالية ؟',
    ),
    Question(text: 'هل تستشير مستشاراً مالياً قبل اتخاذ قرارات الاستثمار ؟'),
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(question.text, style: TextStyles.regular18),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<bool>(
                      title: const Text('نعم'),
                      value: true,
                      activeColor: AppColors.primary,
                      groupValue: question.isChecked,
                      onChanged: (value) {
                        setState(() {
                          question.isChecked = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<bool>(
                      title: const Text('لا'),
                      activeColor: AppColors.primary,
                      value: false,
                      groupValue: question.isChecked,
                      onChanged: (value) {
                        setState(() {
                          question.isChecked = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              if (index != questions.length - 1) AppSpacer(heightRatio: 0.5),
            ],
          );
        },
      ),
    );
  }
}

class Question {
  final String text;
  bool? isChecked; // true = نعم, false = لا, null = لسه مختارش

  Question({required this.text, this.isChecked});
}
