import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/core/usecases/usecases.dart';
import 'package:investhub_app/core/widgets/toast.dart';
import 'package:investhub_app/features/home/domain/entities/subscription_package.dart';
import 'package:investhub_app/features/home/domain/usecases/get_subscriptions_usecase.dart';

part 'subscriptions_state.dart';

class SubscriptionsCubit extends Cubit<SubscriptionsState> {
  final GetSubscriptionsUsecase getSubscriptionsUsecase;

  SubscriptionsCubit({required this.getSubscriptionsUsecase})
    : super(SubscriptionsInitial());

  List<SubscriptionPackage> subscriptions = [];

  Future<void> getSubscriptions() async {
    if (state is SubscriptionsLoading) return;
    emit(SubscriptionsLoading());
    final Either<Failure, SubscriptionsResponse> result =
        await getSubscriptionsUsecase(NoParams());
    result.fold(
      (Failure fail) {
        showErrorToast(fail.message);
        emit(SubscriptionsError(message: fail.message));
      },
      (SubscriptionsResponse response) {
        subscriptions = response.data;
        emit(SubscriptionsSuccess(subscriptions: response.data));
      },
    );
  }
}
