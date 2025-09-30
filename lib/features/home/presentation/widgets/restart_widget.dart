import 'package:flutter/material.dart';

class RestartWidget extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  RestartWidget({required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()!.restartApp();
  }

  @override
  // ignore: library_private_types_in_public_api
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    if (mounted) {
      setState(() {
        key = UniqueKey();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(key: key, child: widget.child);
  }
}
