import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';

class CustomStepper extends StatelessWidget {
  final int currentStep;
  final List<String> steps;
  final Color inactiveColor;

  const CustomStepper({
    super.key,
    required this.currentStep,
    required this.steps,

    this.inactiveColor = AppColors.lightGrey,
  });

  @override
  Widget build(BuildContext context) {
    Color activeColor = Theme.of(context).primaryColor;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 0; i < steps.length; i++) ...[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildCircle(i, activeColor),
              AppSpacer(heightRatio: 0.3),
              Text(
                steps[i],
                style: TextStyles.regular14.copyWith(
                  color: currentStep >= i ? activeColor : inactiveColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          if (i < steps.length - 1)
            Expanded(
              child: Container(
                height: 2.sp,
                margin: EdgeInsets.only(bottom: 20.sp),
                color: currentStep > i
                    ? activeColor
                    : inactiveColor.withValues(alpha: 0.3),
              ),
            ),
        ],
      ],
    );
  }

  Widget _buildCircle(int index, Color activeColor) {
    final bool isCompleted = currentStep > index;
    final bool isActive = currentStep == index;

    Color circleColor;
    Widget child;

    if (isCompleted) {
      circleColor = activeColor;
      child = Icon(Icons.check, color: Colors.white, size: 16.sp);
    } else if (isActive) {
      circleColor = activeColor;
      child = Text(
        '${index + 1}',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      circleColor = inactiveColor.withValues(alpha: 0.3);
      child = Text(
        '${index + 1}',
        style: TextStyle(color: inactiveColor, fontSize: 15.sp),
      );
    }

    return Container(
      width: 30.sp,
      height: 30.sp,
      decoration: BoxDecoration(color: circleColor, shape: BoxShape.circle),
      child: Center(child: child),
    );
  }
}
