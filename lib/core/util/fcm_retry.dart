import 'package:firebase_notifications_handler/firebase_notifications_handler.dart';

Future<void> waitForFcmToken({int maxRetries = 20}) async {
  int retries = 0;
  while ((FirebaseNotificationsHandler.fcmToken?.isEmpty ?? true) &&
      retries < maxRetries) {
    await Future.delayed(const Duration(milliseconds: 200));
    retries++;
  }
}
