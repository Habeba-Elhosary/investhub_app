import 'package:investhub_app/features/home/domain/entities/bottom_navigation_entity.dart';
import 'package:investhub_app/features/home/presentation/cubits/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:investhub_app/features/home/presentation/widgets/bottom_navigation_bar.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BottomNavigationCubit>(),
      child: Builder(
        builder: (context) {
          List<BottomNavigationEntity> items = context
              .read<BottomNavigationCubit>()
              .items;
          return BlocBuilder<BottomNavigationCubit, int>(
            builder: (context, index) {
              return Scaffold(
                body: items[index].page,
                bottomNavigationBar: BottomNavBar(),
              );
            },
          );
        },
      ),
    );
  }
}
