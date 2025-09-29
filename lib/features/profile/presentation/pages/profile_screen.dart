import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/features/profile/presentation/widgets/profile_body.dart';
import 'package:investhub_app/features/profile/presentation/widgets/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 370.sp,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  ClipPath(
                    clipper: BottomRoundedClipper(),
                    child: Container(color: AppColors.primary, height: 300.sp),
                  ),
                  Positioned(top: 90.h, child: ProfileHeader()),
                ],
              ),
            ),
            Expanded(child: ProfileBody()),
          ],
        ),
      ),
    );
  }
}

class BottomRoundedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Start top-left
    path.lineTo(0, size.height - 100);

    // Draw arc to right side
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 100,
    );

    // Right side up
    path.lineTo(size.width, 0);

    // Close the path
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
