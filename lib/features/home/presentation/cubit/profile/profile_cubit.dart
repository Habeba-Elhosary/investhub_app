import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investhub_app/core/widgets/toast.dart';
import 'package:investhub_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:investhub_app/features/auth/data/models/auth_response.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthLocalDataSource localDataSource;

  ProfileCubit({required this.localDataSource}) : super(ProfileInitial());

  Future<void> loadUserData() async {
    if (state is ProfileLoading) return;
    emit(ProfileLoading());

    try {
      final User user = await localDataSource.getCacheUser();
      emit(ProfileSuccess(user: user));
    } catch (e) {
      final errorMessage = 'فشل في تحميل بيانات المستخدم';
      showErrorToast(errorMessage);
      emit(ProfileError(message: errorMessage));
    }
  }
}
