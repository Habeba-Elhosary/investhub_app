import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';

class OpportunitiesScreen extends StatelessWidget {
  const OpportunitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.home_oppurtunities.tr())),
      body: const Center(child: Text('Opportunities Screen')),
    );
  }
}
