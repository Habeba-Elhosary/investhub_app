import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/widgets/toast.dart';
import 'package:investhub_app/features/auth/data/models/auth_response.dart';
import 'package:investhub_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:investhub_app/features/auth/presentation/cubits/auto_login/auto_login_cubit.dart';
import 'package:investhub_app/features/home/presentation/pages/main_screen.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase loginUsecase;
  LoginCubit({required this.loginUsecase}) : super(LoginInitial());
  Future<void> loginEvent({
    required String phone,
    required String password,
  }) async {
    emit(LoginLoading());
    final Either<Failure, AuthResponse> failureOrUser = await loginUsecase(
      LoginParams(phone: phone, password: password),
    );
    failureOrUser.fold(
      (Failure faile) {
        emit(LoginError(message: faile.message));
        showErrorToast(faile.message);
      },
      (AuthResponse authResponse) {
        showSucessToast(authResponse.message!);
        sl<AutoLoginCubit>().setUser = authResponse.data;
        emit(LoginSuccess());
        sl<AutoLoginCubit>().emitHasUserAsState();
        appNavigator.popUtill(screen: const MainScreen());
      },
    );
  }
}
