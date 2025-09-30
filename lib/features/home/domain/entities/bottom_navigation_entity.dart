import 'package:flutter/material.dart';

class BottomNavigationEntity {
  final String icon;
  final String title;
  final Widget page;

  BottomNavigationEntity({
    required this.icon,
    required this.title,
    required this.page,
  });
}
