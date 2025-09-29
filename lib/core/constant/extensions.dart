// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final StringBuffer buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}


extension ServerDateFormat on DateTime {
  String serverDateFormat() {
    return DateFormat('yyyy-MM-dd', 'en').format(this);
  }
}

extension ArabicToEnglishNumbers on String {
  String toEnglishNumbers() {
    // Regular expressions to check if the string contains only Arabic or English numbers
    final RegExp arabicNumbersRegex = RegExp(r'^[٠-٩]+$');
    final RegExp englishNumbersRegex = RegExp(r'^[0-9]+$');

    // Check if the string contains only Arabic or only English numbers
    if (arabicNumbersRegex.hasMatch(this)) {
      // Map of Arabic numerals to English numerals
      const Map<String, String> arabicToEnglishNumbers = <String, String>{
        '٠': '0',
        '١': '1',
        '٢': '2',
        '٣': '3',
        '٤': '4',
        '٥': '5',
        '٦': '6',
        '٧': '7',
        '٨': '8',
        '٩': '9',
      };
      String output = this;
      arabicToEnglishNumbers.forEach((String arabic, String english) {
        output = output.replaceAll(arabic, english);
      });
      return output;
    } else if (englishNumbersRegex.hasMatch(this)) {
      return this;
    } else {
      return this;
    }
  }
}
