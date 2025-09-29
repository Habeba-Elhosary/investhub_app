// ignore_for_file: constant_identifier_names

enum StaticDataType { phone, about_app, privacy }

StaticDataType getStaticDataTypeFromString(String type) {
  switch (type) {
    case "phone":
      return StaticDataType.phone;
    case "about-app":
      return StaticDataType.about_app;
    case "privacy":
      return StaticDataType.privacy;
    default:
      return StaticDataType.phone;
  }
}

String getStaticDataTypeString(StaticDataType type) {
  switch (type) {
    case StaticDataType.phone:
      return 'phone';
    case StaticDataType.about_app:
      return 'about-app';
    case StaticDataType.privacy:
      return 'privacy';
  }
}
