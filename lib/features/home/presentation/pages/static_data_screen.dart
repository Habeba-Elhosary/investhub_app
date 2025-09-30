import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/size_config.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';

class StaticDataScreen extends StatelessWidget {
  final String title;
  const StaticDataScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), elevation: 0.2),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: SizeConfig.paddingSymmetric,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.app_name.tr(),
                    style: TextStyles.bold24.copyWith(
                      color: AppColors.primary,
                      fontStyle: FontStyle.italic,
                      fontSize: 27.sp,
                    ),
                  ),
                  Image.asset(
                    AppAssets.imagesSplashLogo,
                    height: 30.sp,
                    color: AppColors.primary,
                  ),
                ],
              ),
              AppSpacer(heightRatio: 1),
              Text('''
نحن في  InvestHub نؤمن أن المعرفة هي المفتاح لاتخاذ قرارات أفضل، وأن كل مستثمر يستحق أن يحصل على المعلومات بشكل مبسط، شفاف، وموثوق. لهذا صممنا هذا التطبيق ليكون منصة متكاملة تهدف إلى تمكين المستخدمين من فهم الأسواق المالية بسهولة، والتعرف على الفرص الاستثمارية الواعدة، ومتابعة حركة الأسهم والشركات لحظة بلحظة.

يقدم التطبيق تجربة سلسة وبديهية تتيح لك الاطلاع على أحدث البيانات والتحليلات المالية من مصادر معتمدة، مدعومة بتقنيات حديثة تضمن دقة المعلومات وسرعة وصولها إليك. نحن نعمل باستمرار على تطوير أدوات تساعدك على تحليل الأداء المالي للشركات، مقارنة الفرص الاستثمارية، وتحديد الأهداف التي تتناسب مع احتياجاتك.

لا يقتصر دورنا على تزويدك بالأرقام فقط، بل نحرص أيضًا على تبسيط المفاهيم الاقتصادية والاستثمارية المعقدة، وتحويلها إلى محتوى واضح وسهل الاستيعاب حتى يتمكن أي مستخدم، سواء كان مبتدئًا أو محترفًا، من الاستفادة القصوى.

رؤيتنا هي أن نصبح الشريك الموثوق لكل مستثمر في رحلته المالية، فنحن نطمح إلى أن نكون المنصة الأولى التي يعتمد عليها المستخدم لاتخاذ قراراته بثقة، مدعومة بالعلم والخبرة والشفافية. رسالتنا أن نجعل الاستثمار في متناول الجميع، ونفتح أبواب الفرص أمام كل من يسعى لتحقيق الاستقلال المالي وبناء مستقبل أكثر استقرارًا وازدهارًا.
             ''', style: TextStyles.regular16.copyWith(height: 2.sp)),
            ],
          ),
        ),
      ),
    );
  }
}
