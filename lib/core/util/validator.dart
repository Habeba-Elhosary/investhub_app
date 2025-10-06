import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class Validator {
  static String? defaultValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.validationMessages_error_filed_required.tr();
    }

    return null;
  }

  static String? name(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return LocaleKeys.validationMessages_error_filed_required.tr();
      }
      // if (value.split(' ').length < 3) {
      //   return LocaleKeys.validationMessages_name_must_trio.tr();
      // }
      if (value.length < 3) {
        return LocaleKeys.validationMessages_name_short_input.tr();
      }
    }
    return null;
  }

  static String? registerAddress(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return LocaleKeys.validationMessages_error_filed_required.tr();
      }
      if (value.length < 4) {
        return LocaleKeys.validationMessages_short_address.tr();
      }
    }
    return null;
  }

  static const String urlPattern =
      r'((https?:\/\/)?([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})(:[0-9]{1,5})?(\/\S*)?)';
  static RegExp urlRegex = RegExp(urlPattern);

  static String? text(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return LocaleKeys.validationMessages_error_filed_required.tr();
      } else if (!RegExp('[a-zA-Z]').hasMatch(value)) {
        return LocaleKeys.validationMessages_enter_correct_name.tr();
      }
    }
    return null;
  }

  static String? defaultEmptyValidator(String? value) {
    return null;
  }

  static String? email(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return LocaleKeys.validationMessages_error_filed_required.tr();
      } else if (!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      ).hasMatch(value)) {
        return LocaleKeys.validationMessages_error_email_regex.tr();
      }
    } else {
      return LocaleKeys.validationMessages_error_filed_required.tr();
    }
    return null;
  }

  static String? password(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return LocaleKeys.validationMessages_error_filed_required.tr();
      }
      if (value.length < 8) {
        return LocaleKeys.validationMessages_error_password_validation.tr();
      }
    }
    return null;
  }

  static String? confirmPassword(String? confirmPassword, String? password) {
    if (confirmPassword != null) {
      confirmPassword = confirmPassword.trim();
      if (confirmPassword.isEmpty) {
        return LocaleKeys.validationMessages_error_filed_required.tr();
      } else if (confirmPassword != password) {
        return LocaleKeys.validationMessages_error_wrong_password_confirm.tr();
      }
    } else {
      return LocaleKeys.validationMessages_error_filed_required.tr();
    }
    return null;
  }

  static String? numbers(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return LocaleKeys.validationMessages_error_filed_required.tr();
      }
      if (value.startsWith('+')) {
        value = value.replaceFirst(r'+', '');
      }
      final int? number = int.tryParse(value);
      if (number == null) {
        return LocaleKeys.validationMessages_error_wrong_input.tr();
      }
    } else {
      return LocaleKeys.validationMessages_error_filed_required.tr();
    }
    return null;
  }

  static String? phone(String? value) {
    RegExp regExp = RegExp(r'^01[0-2-5]{1}[0-9]{8}$');
    if (value == null || value.isEmpty) {
      return LocaleKeys.validationMessages_error_filed_required.tr();
    }
    bool containsArabic = value.contains(RegExp(r'[٠-٩]'));
    bool containsEnglish = value.contains(RegExp(r'[0-9]'));
    if (!regExp.hasMatch(value) && (containsArabic && containsEnglish)) {
      return LocaleKeys.validationMessages_invalid_phone.tr();
    }
    return null;
  }

  static String? positiveNumbers(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return LocaleKeys.validationMessages_error_filed_required.tr();
      }
      if (value.startsWith('+')) {
        value = value.replaceFirst(r'+', '');
      }
      final double? number = double.tryParse(value);
      if (number == null) {
        return LocaleKeys.validationMessages_error_wrong_input.tr();
      }
      if (number <= 0) {
        return LocaleKeys.validationMessages_error_must_be_positive.tr();
      }
    } else {
      return LocaleKeys.validationMessages_error_filed_required.tr();
    }
    return null;
  }
}
