import 'package:flutter/material.dart';

class BottomNavigationEntity {
  final String icon;
  final String activeIcon;
  final String title;
  final Widget page;

  BottomNavigationEntity({
    required this.icon,
    required this.activeIcon,
    required this.title,
    required this.page,
  });
}
