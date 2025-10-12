import 'package:investhub_app/core/util/api_base_helper.dart';
import 'package:investhub_app/features/home/domain/entities/opportunity.dart';
import 'package:investhub_app/features/home/domain/entities/subscription_package.dart';
import 'package:investhub_app/features/home/domain/entities/subscribe_response.dart';

const String getSubscriptionsAPI = '/subscriptions/packages';
const String subscribeAPI = '/subscriptions/subscribe';
const String getOpportunitiesAPI = '/investments';

abstract class SubscriptionsRemoteDataSource {
  Future<SubscriptionsResponse> getSubscriptions();
  Future<SubscribeResponse> subscribe({
    required int subscriptionId,
    required String token,
  });
  Future<OpportunitiesResponse> getOpportunities();
}

class SubscriptionsRemoteDataSourceImpl
    implements SubscriptionsRemoteDataSource {
  final ApiBaseHelper apiBaseHelper;

  SubscriptionsRemoteDataSourceImpl({required this.apiBaseHelper});

  @override
  Future<SubscriptionsResponse> getSubscriptions() async {
    try {
      final response = await apiBaseHelper.get(url: getSubscriptionsAPI);
      return SubscriptionsResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SubscribeResponse> subscribe({
    required int subscriptionId,
    required String token,
  }) async {
    try {
      final response = await apiBaseHelper.post(
        url: subscribeAPI,
        body: <String, dynamic>{
          "package_id": subscriptionId,
          "payment_method": "visa",
        },
        token: token,
      );
      return SubscribeResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<OpportunitiesResponse> getOpportunities() async {
    try {
      final response = await apiBaseHelper.get(url: getOpportunitiesAPI);
      return OpportunitiesResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
