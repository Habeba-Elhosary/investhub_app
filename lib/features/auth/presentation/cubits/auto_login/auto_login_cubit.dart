import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/features/auth/data/models/auth_response.dart';
import 'package:investhub_app/features/auth/domain/usecases/auto_login_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auto_login_state.dart';

class AutoLoginCubit extends Cubit<AutoLoginState> {
  final AutoLoginUsecase autoLoginUsecase;
  AutoLoginCubit({required this.autoLoginUsecase}) : super(AutoLoginInitial());

  late User _user;
  User get user => _user;
  set setUser(User user) => _user = user;
  Future<void> fAutoLogin() async {
    emit(AutoLoginLoading());
    final Either<Failure, User> failOrUser = await autoLoginUsecase(NoParams());
    failOrUser.fold(
      (Failure fail) async {
        emit(AutoLoginNoUser());
      },
      (User user) async {
        _user = user;
        emit(const AutoLoginHasUser());
            },
    );
  }

  void emitHasUserAsState() {
    emit(AutoLoginInitial());
    emit(const AutoLoginHasUser());
  }

  void emitSeenIntro() {
    emit(AutoLoginInitial());
    emit(AutoLoginSeenIntro());
  }

  void logout() {
    emit(AutoLoginInitial());
    emit(AutoLoginNoUser());
  }
}
