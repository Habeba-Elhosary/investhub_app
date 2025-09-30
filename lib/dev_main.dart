import 'package:flutter/material.dart';
import 'core/flavors/flavors_config.dart';
import 'main.dart' as runner;

void main() {
  FlavorConfig(
    color: Colors.white,
    name: 'DEV',
    location: BannerLocation.topStart,
    variables: <String, dynamic>{
      'baseUrl': 'https://eccomerce-elkhoday.true-cons.net/api',
    },
  );
  runner.main();
}
