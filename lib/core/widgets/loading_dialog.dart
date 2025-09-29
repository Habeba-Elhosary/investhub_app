import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 72.h),
      child: SizedBox(
        width: 64.w,
        height: 64.h,
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}