import 'package:investhub_app/core/enums/educational_status_enum.dart';
import 'package:investhub_app/core/enums/marital_status_enum.dart';
import 'package:investhub_app/features/general/domain/entities/banks_response.dart';

class EditProfileParams {
  final String name;
  final String email;
  final String phone;
  final String nationalId;
  final String birthDate;
  final MaritalStatus maritalStatus;
  final int familyNum;
  final EducationalStatus educationalLevel;
  final num annualIncome;
  final num totalSaving;
  final Bank bank;
  final List<Map<String, dynamic>> answers;

  const EditProfileParams({
    required this.name,
    required this.email,
    required this.phone,
    required this.nationalId,
    required this.birthDate,
    required this.maritalStatus,
    required this.familyNum,
    required this.educationalLevel,
    required this.annualIncome,
    required this.totalSaving,
    required this.bank,
    required this.answers,
  });

   String _convertArabicToEnglishNumbers(String input) {
    const arabicNumbers = '٠١٢٣٤٥٦٧٨٩';
    const englishNumbers = '0123456789';
    
    String result = input;
    for (int i = 0; i < arabicNumbers.length; i++) {
      result = result.replaceAll(arabicNumbers[i], englishNumbers[i]);
    }
    return result;
  }


  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
    "national_id": nationalId,
    "date_of_birth": _convertArabicToEnglishNumbers(birthDate),
    "marital_status": maritalStatus.name,
    "family_members_count": familyNum,
    "education_level": educationalLevel.name,
    "annual_income": annualIncome,
    "total_savings": totalSaving,
    "bank_id": bank.id,
    "answers": answers,
    "Method": "PUT",
  };
}
