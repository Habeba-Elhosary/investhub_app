import 'package:investhub_app/app.dart';
import 'package:flutter/material.dart';
import '../widgets/app_dialogs.dart';

class AppNavigator {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Future<void> push({
    required Widget screen,
    bool fullscreenDialog = false,
  }) async {
    await navigatorKey.currentState!.push(
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => screen,
        fullscreenDialog: fullscreenDialog,
      ),
    );
  }

  Future<void> pushReplacement({required Widget screen}) async {
    await navigatorKey.currentState!.pushReplacement(
      MaterialPageRoute<dynamic>(builder: (BuildContext context) => screen),
    );
  }

  dynamic pop({dynamic object}) {
    return navigatorKey.currentState!.pop<dynamic>(object);
  }

  dynamic popUtill({required Widget screen}) {
    return navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute<dynamic>(builder: (BuildContext c) => screen),
      (Route<dynamic> route) => false,
    );
  }

  dynamic popToFrist({dynamic object}) {
    return navigatorKey.currentState!.popUntil(
      (Route<dynamic> rout) => rout.isFirst,
    );
  }

  dynamic showDialog({required Widget child, bool? isDismissible}) {
    return AppDialogs.showAppDialog(
      navigatorKey.currentContext!,
      child,
      isDismissible: isDismissible,
    );
  }

  dynamic showSheet({required Widget child}) {
    return AppDialogs.showAppSheet(navigatorKey.currentContext!, child);
  }

  dynamic popToRawy({dynamic object}) {
    return navigatorKey.currentState!.pushAndRemoveUntil(
      // ignore: always_specify_types
      MaterialPageRoute(
        builder: (BuildContext context) => const InvestHubApp(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  dynamic popAndRemoveAll({Widget? screen}) {
    if (screen != null) {
      // Push the new screen and remove all previous routes
      return navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute<dynamic>(builder: (BuildContext context) => screen),
        (Route<dynamic> route) => false,
      );
    } else {
      // Pop all routes until the stack is empty (or reaches the first route)
      return navigatorKey.currentState!.popUntil(
        (Route<dynamic> route) => route.isFirst,
      );
    }
  }
}
