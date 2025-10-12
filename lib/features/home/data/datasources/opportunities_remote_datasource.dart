import 'package:investhub_app/core/util/api_base_helper.dart';
import 'package:investhub_app/features/home/domain/entities/opportunity.dart';

const String getOpportunitiesAPI = '/investments';

abstract class OpportunitiesRemoteDataSource {
  Future<OpportunitiesResponse> getOpportunities({int page = 1});
}

class OpportunitiesRemoteDataSourceImpl
    implements OpportunitiesRemoteDataSource {
  final ApiBaseHelper apiBaseHelper;

  OpportunitiesRemoteDataSourceImpl({required this.apiBaseHelper});

  @override
  Future<OpportunitiesResponse> getOpportunities({int page = 1}) async {
    try {
      final response = await apiBaseHelper.get(
        url: getOpportunitiesAPI,
        queryParameters: {'page': page,},
      );
      return OpportunitiesResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
