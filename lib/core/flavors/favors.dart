enum AppFlavor {
  dev,
  prod;
}

extension FlavorsExtension on String? {
  AppFlavor get flavor {
    switch (this) {
      case 'DEV':
        return AppFlavor.dev;
      case 'PROD':
        return AppFlavor.prod;
      default:
        return AppFlavor.dev;
    }
  }
}
