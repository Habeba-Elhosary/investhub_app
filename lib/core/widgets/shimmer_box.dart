import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShimmerBox extends StatelessWidget {
  final double height;
  final double width;
  final EdgeInsets? padding;
  final double? borderRadius;
  final BoxShape? shape;
  const ShimmerBox({
    super.key,
    required this.height,
    required this.width,
    this.padding,
    this.borderRadius,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.sp,
      width: width.sp,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: shape ?? BoxShape.rectangle,
        borderRadius:
            borderRadius != null ? BorderRadius.circular(borderRadius!.r) : null,
      ),
    );
  }
}
