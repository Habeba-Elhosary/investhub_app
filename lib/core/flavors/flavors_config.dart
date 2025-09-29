// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

/// FlavorConfig to configure flavors
class FlavorConfig {
  /// Name of flavor
  final String? name;

  /// Color of the banner
  final Color color;

  /// Location of the banner
  final BannerLocation location;

  /// Variables are dynamic
  final Map<String, dynamic> variables;

  /// Private constructor
  FlavorConfig._internal(this.name, this.color, this.location, this.variables);

  /// Internal instance of FlavorConfig
  static FlavorConfig? _instance;

  /// Instance of FlavorConfig
  static FlavorConfig get instance {
    _instance ??= FlavorConfig();

    return _instance!;
  }

  /// Factory constructor
  factory FlavorConfig({
    String? name,
    Color color = Colors.red,
    BannerLocation location = BannerLocation.topStart,
    Map<String, dynamic> variables = const <String, dynamic>{},
  }) {
    _instance = FlavorConfig._internal(
      name,
      color,
      location,
      variables,
    );

    return _instance!;
  }
  factory FlavorConfig.formJson(Map<String, dynamic> json) {
    _instance = FlavorConfig._internal(
      json['name'],
      Color(json['color']),
      BannerLocation.values.byName(json['location']),
      Map.from(json['variables'])
          .map((key, value) => MapEntry<String, dynamic>(key, value)),
    );

    return _instance!;
  }
  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'color': color.value,
        'location': location.name,
        'variables': Map<String, dynamic>.from(variables),
      };
}
