import 'package:investhub_app/core/util/api_base_helper.dart';
import 'package:investhub_app/features/auth/data/models/auth_response.dart';
import 'package:investhub_app/features/home/domain/entities/edit_profile_params.dart';

const String editProfileAPI = '/user/profile';

abstract class EditProfileRemoteDataSource {
  Future<AuthResponse> editProfile(EditProfileParams params, String token);
}

class EditProfileRemoteDataSourceImpl implements EditProfileRemoteDataSource {
  final ApiBaseHelper apiBaseHelper;

  EditProfileRemoteDataSourceImpl({required this.apiBaseHelper});

  @override
  Future<AuthResponse> editProfile(EditProfileParams params, String token) async {
    try {
      final response = await apiBaseHelper.post(
        url: editProfileAPI,
        body: params.toJson(),
        token: token,
      );
      return AuthResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
