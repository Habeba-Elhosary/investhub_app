import 'package:easy_localization/easy_localization.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';

enum EducationalStatus { highSchool, diploma, bachelor, master, phd, other }

EducationalStatus getEducationalStatusFromString(String type) {
  switch (type) {
    case "high_school":
      return EducationalStatus.highSchool;
    case "diploma":
      return EducationalStatus.diploma;
    case "bachelor":
      return EducationalStatus.bachelor;
    case "master":
      return EducationalStatus.master;
    case "phd":
      return EducationalStatus.phd;
    case "other":
      return EducationalStatus.other;
    default:
      return EducationalStatus.highSchool;
  }
}

String getEducationalStatusString(EducationalStatus type) {
  switch (type) {
    case EducationalStatus.highSchool:
      return LocaleKeys.educational_status_high_school.tr();
    case EducationalStatus.diploma:
      return LocaleKeys.educational_status_diploma.tr();
    case EducationalStatus.bachelor:
      return LocaleKeys.educational_status_bachelor.tr();
    case EducationalStatus.master:
      return LocaleKeys.educational_status_master.tr();
    case EducationalStatus.phd:
      return LocaleKeys.educational_status_phd.tr();
    case EducationalStatus.other:
      return LocaleKeys.educational_status_others.tr();
  }
}
