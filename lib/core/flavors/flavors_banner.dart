
import 'flavors_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Widget for draw banner
class FlavorBanner extends StatelessWidget {
  /// Widget inside FlavorBanner
  final Widget? child;

  /// Color of the banner
  final Color? color;

  /// Location of the banner
  final BannerLocation? location;

  const FlavorBanner({
    super.key,
    this.child,
    this.color,
    this.location,
  });

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) {
      return child!;
    }
    if (FlavorConfig.instance.name == null ||
        FlavorConfig.instance.name?.isEmpty == true) {
      return child!;
    }

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Banner(
        color: color ?? FlavorConfig.instance.color,
        message: FlavorConfig.instance.name ?? '',
        location: location ?? FlavorConfig.instance.location,
        textStyle: TextStyle(
          color: _color,
          fontSize: 12.0 * 0.85,
          fontWeight: FontWeight.w900,
          height: 1.0,
        ),
        child: child,
      ),
    );
  }

  Color get _color =>
      HSLColor.fromColor(color ?? FlavorConfig.instance.color).lightness < 0.8
          ? Colors.white
          : Colors.black87;
}
