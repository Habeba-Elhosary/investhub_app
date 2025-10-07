// ignore_for_file: constant_identifier_names

import 'package:easy_localization/easy_localization.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';

enum MaritalStatus { single, married, divorced, widowed }

MaritalStatus getMaritalStatusFromString(String type) {
  switch (type) {
    case "single":
      return MaritalStatus.single;
    case "married":
      return MaritalStatus.married;
    case "divorced":
      return MaritalStatus.divorced;
    case "widowed":
      return MaritalStatus.widowed;
    default:
      return MaritalStatus.single;
  }
}

String getMaritalStatusValue(MaritalStatus type) {
  switch (type) {
    case MaritalStatus.single:
      return "single";
    case MaritalStatus.married:
      return "married";
    case MaritalStatus.divorced:
      return "divorced";
    case MaritalStatus.widowed:
      return "widowed";
  }
}

String getMaritalStatusString(MaritalStatus type) {
  switch (type) {
    case MaritalStatus.single:
      return LocaleKeys.marital_status_single.tr();
    case MaritalStatus.married:
      return LocaleKeys.marital_status_married.tr();
    case MaritalStatus.divorced:
      return LocaleKeys.marital_status_divorced.tr();
    case MaritalStatus.widowed:
      return LocaleKeys.marital_status_widowed.tr();
  }
}
