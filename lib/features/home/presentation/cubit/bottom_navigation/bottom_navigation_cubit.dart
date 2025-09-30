import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/features/home/domain/entities/bottom_navigation_entity.dart';
import 'package:investhub_app/features/home/presentation/pages/opportunities_screen.dart';
import 'package:investhub_app/features/home/presentation/pages/profile_screen.dart';
import 'package:investhub_app/features/home/presentation/pages/subscriptions_screen.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';

class BottomNavigationCubit extends Cubit<int> {
  BottomNavigationCubit() : super(0);

  void changeIndex(int index) => emit(index);

  List<BottomNavigationEntity> items = [
    BottomNavigationEntity(
      icon: AppAssets.imagesHome,
      title: LocaleKeys.home_oppurtunities,
      page: OpportunitiesScreen(),
    ),
    BottomNavigationEntity(
      icon: AppAssets.imagesPackages,
      title: LocaleKeys.home_subscriptions,
      page: SubscriptionsScreen(),
    ),
    BottomNavigationEntity(
      icon: AppAssets.imagesUser,
      title: LocaleKeys.home_profile,
      page: ProfileScreen(),
    ),
  ];
}
