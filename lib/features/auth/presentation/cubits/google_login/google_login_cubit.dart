import 'package:easy_localization/easy_localization.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/widgets/toast.dart';
import 'package:investhub_app/features/auth/data/models/auth_response.dart';
import 'package:investhub_app/features/auth/domain/usecases/google_login_usecase.dart';
import 'package:investhub_app/features/auth/presentation/cubits/auto_login/auto_login_cubit.dart';
import 'package:investhub_app/features/home/presentation/pages/main_screen.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'google_login_state.dart';

class GoogleLoginCubit extends Cubit<GoogleLoginState> {
  final GoogleLoginUsecase googleLoginUsecase;
  GoogleLoginCubit({required this.googleLoginUsecase})
    : super(GoogleLoginInitial());
  Future<void> googleLoginEvent() async {
    emit(GoogleLoginLoading());
    final googleCredentials = await _getGoogleCredentials();
    googleCredentials.fold(
      (Failure failure) {
        emit(GoogleLoginError(message: failure.message));
        showErrorToast(failure.message);
      },
      (SocialCredentials socialCredentials) async {
        final Either<Failure, AuthResponse> failureOrUser =
            await googleLoginUsecase(
              GoogleLoginParams(socialCredentials: socialCredentials),
            );
        failureOrUser.fold(
          (Failure failure) {
            emit(GoogleLoginError(message: failure.message));
            showErrorToast(failure.message);
          },
          (AuthResponse authResponse) {
            showSucessToast(authResponse.message!);
            sl<AutoLoginCubit>().setUser = authResponse.data;
            emit(GoogleLoginSuccess());
            sl<AutoLoginCubit>().emitHasUserAsState();
            appNavigator.popUtill(screen: const MainScreen());
          },
        );
      },
    );
  }

  static Future<Either<Failure, SocialCredentials>>
  _getGoogleCredentials() async {
    try {
      final GoogleSignIn signIn = GoogleSignIn.instance;

      await signIn.initialize();

      await signIn.signOut();

      final GoogleSignInAccount account = await signIn.authenticate();

      const List<String> scopes = <String>[
        'email',
        'https://www.googleapis.com/auth/userinfo.profile',
      ];

      final GoogleSignInServerAuthorization? serverAuth = await account
          .authorizationClient
          .authorizeServer(scopes);

      final socialCredentials = SocialCredentials(
        socialToken: serverAuth?.serverAuthCode,
        name: account.displayName,
        email: account.email,
        image: account.photoUrl,
      );
      return Right(socialCredentials);
    } catch (e) {
      print(e.toString());
      return Left(
        ServerFailure(
          message:
              e.toString() ?? LocaleKeys.errorsMessage_please_try_again.tr(),
        ),
      );
    }
  }
}

class SocialCredentials {
  final String? name, email, image, socialToken;

  SocialCredentials({
    required this.name,
    required this.email,
    required this.image,
    this.socialToken,
  });

  Map<String, dynamic> toJson() => {
    if (name != null) 'name': name,
    if (email != null) 'email': email,
    if (image != null) 'image': image,
    if (socialToken != null) 'social_token': socialToken,
  };
}
