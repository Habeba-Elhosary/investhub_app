import 'package:investhub_app/core/entities/status_response.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/core/widgets/toast.dart';
import 'package:investhub_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:investhub_app/features/auth/presentation/cubits/auto_login/auto_login_cubit.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final LogoutUsecase logoutUsecase;
  LogoutCubit({required this.logoutUsecase}) : super(LogoutInitial());
  Future<void> logoutEvent() async {
    emit(LogoutLoading());
    final Either<Failure, StatusResponse> failOrSuccess = await logoutUsecase(
      NoParams(),
    );
    failOrSuccess.fold(
      (Failure fail) {
        emit(LogoutError(message: fail.message));
        showErrorToast(fail.message);
      },
      (StatusResponse statusResponse) {
        emit(LogoutSuccess());
        // appNavigator.popUtill(screen: const MainScreen());
        // sl<BottomNavigationCubit>().changeIndex(0);
        sl<AutoLoginCubit>().logout();
        showSucessToast(statusResponse.message);
      },
    );
  }
}
