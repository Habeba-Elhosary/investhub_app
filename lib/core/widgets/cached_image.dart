import 'package:investhub_app/core/widgets/shimmer_box.dart';
import 'package:investhub_app/core/widgets/shimmer_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CacheNetworkImage extends StatelessWidget {
  final double? height, width;
  final String imageUrl;
  final BoxFit fit;
  final double radius;
  const CacheNetworkImage({
    super.key,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.radius = 8,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        height: height,
        width: width,
        placeholder: (context, url) => ShimmerLoading(
          widget: ShimmerBox(height: height ?? 30.sp, width: 30.sp),
        ),
        fit: fit,
        errorWidget: (context, url, error) =>
            Icon(Icons.error, color: Colors.red),
        imageUrl: imageUrl,
      ),
    );
  }
}
