import 'package:investhub_app/core/util/api_base_helper.dart';
import 'package:investhub_app/features/general/domain/entities/banks_response.dart';
import 'package:investhub_app/features/general/domain/entities/registration_questions_response.dart';

const String getBanksAPI = '/banks';
const String getRegistrationQuestionsAPI = '/registration-questions';

abstract class GeneralRemoteDataSource {
  Future<BanksResponse> getBanks();
  Future<RegistrationQuestionsResponse> getRegistrationQuestions();
}

class GeneralRemoteDataSourceImpl implements GeneralRemoteDataSource {
  final ApiBaseHelper apiBaseHelper;
  GeneralRemoteDataSourceImpl({required this.apiBaseHelper});

  @override
  Future<BanksResponse> getBanks() async {
    try {
      final response = await apiBaseHelper.get(url: getBanksAPI);
      return BanksResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<RegistrationQuestionsResponse> getRegistrationQuestions() async {
    try {
      final response = await apiBaseHelper.get(
        url: getRegistrationQuestionsAPI,
      );
      return RegistrationQuestionsResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
