// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/features/auth/presentation/cubits/register/register_cubit.dart';
import 'package:investhub_app/features/general/domain/entities/registration_questions_response.dart';

class RegisterFormThree extends StatefulWidget {
  final RegisterCubit registerCubit;
  const RegisterFormThree({super.key, required this.registerCubit});

  @override
  State<RegisterFormThree> createState() => _RegisterFormThreeState();
}

class _RegisterFormThreeState extends State<RegisterFormThree> {
  final List<Question> questions = [
    Question(question: 'هل لديك خبرة سابقة في الاستثمار بالأسهم ؟', id: 1),
    Question(
      question: 'هل أنت مستعد للمخاطرة بخسارة جزء من رأس المال ؟',
      id: 2,
    ),
    Question(question: 'هل لديك مصدر دخل ثابت لتغطية نفقاتك الأساسية ؟', id: 3),
    Question(
      question: 'هل تخطط لسحب أموالك المستثمرة في غضون 1-3 سنوات ؟',
      id: 4,
    ),
    Question(
      question: 'هل تفضل الاستثمارات ذات العوائد المرتفعة والمخاطر العالية ؟',
      id: 5,
    ),
    Question(
      question: 'هل تستشير مستشاراً مالياً قبل اتخاذ قرارات الاستثمار ؟',
      id: 6,
    ),
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
              Text(question.question, style: TextStyles.regular18),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<bool>(
                      title: const Text('نعم'),
                      value: true,
                      activeColor: AppColors.primary,
                      // groupValue: question.isChecked,
                      onChanged: (value) {
                        setState(() {
                          // question.isChecked = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<bool>(
                      title: const Text('لا'),
                      activeColor: AppColors.primary,
                      value: false,
                      // groupValue: question.isChecked,
                      onChanged: (value) {
                        setState(() {
                          // question.isChecked = value!;
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
