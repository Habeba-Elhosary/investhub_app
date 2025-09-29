import 'package:investhub_app/core/entities/status_response.dart';
import 'package:investhub_app/core/util/api_base_helper.dart';

const String sendComplainAPI = '/auth/send-complaint';
const String getStaticDataAPI = '/auth/static-data';

abstract class GeneralRemoteDataSource {
  Future<StatusResponse> sendComplaint(String content, String token);
  Future<String> getStaticData(String type);
}

class GeneralRemoteDataSourceImpl implements GeneralRemoteDataSource {
  final ApiBaseHelper apiBaseHelper;

  GeneralRemoteDataSourceImpl({required this.apiBaseHelper});

  @override
  Future<StatusResponse> sendComplaint(String content, String token) async {
    try {
      final response = await apiBaseHelper.post(
        url: sendComplainAPI,
        body: <String, dynamic>{'content': content},
        token: token,
      );
      return StatusResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> getStaticData(String type) async {
    try {
      final response = await apiBaseHelper.get(
        url: getStaticDataAPI,
        body: <String, dynamic>{'type': type},
      );
      return response['data']['value'];
    } catch (e) {
      rethrow;
    }
  }
}
