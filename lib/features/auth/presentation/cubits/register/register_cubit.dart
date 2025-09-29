import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/widgets/toast.dart';
import 'package:investhub_app/features/auth/data/models/auth_response.dart';
import 'package:investhub_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:investhub_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:investhub_app/features/auth/presentation/cubits/auto_login/auto_login_cubit.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUsecase registerUsecase;

  RegisterCubit({required this.registerUsecase}) : super(RegisterInitial());
  Future<void> registerEvent({required RegisterParams registerParams}) async {
    emit(RegisterLoading());
    final Either<Failure, AuthResponse> failureOrUser = await registerUsecase(
      registerParams,
    );
    failureOrUser.fold(
      (Failure faile) {
        emit(RegisterError(message: faile.message));
        showErrorToast(faile.message);
      },
      (AuthResponse authResponse) {
        showSucessToast(authResponse.message!);
        emit(RegisterSuccess());
        sl<AutoLoginCubit>().setUser = authResponse.data.user;
        sl<AutoLoginCubit>().emitHasUserAsState();
        // appNavigator.popUtill(screen: const MainScreen());
      },
    );
  }
}
