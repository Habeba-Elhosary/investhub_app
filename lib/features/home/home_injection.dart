import 'package:investhub_app/features/home/presentation/cubit/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:investhub_app/injection_container.dart';

void initHomeInjection() async {
  // * Cubits
  sl.registerFactory(() => BottomNavigationCubit());

  // * Usecases

  // * Repository

  // * Datasources
}
