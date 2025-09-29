import 'package:investhub_app/core/widgets/spinner_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingButton<C extends Cubit<S>, S, L> extends StatelessWidget {
  const LoadingButton({super.key, required this.onTap, required this.title});
  final void Function() onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<C, S>(
      builder: (BuildContext context, S state) {
        return Visibility(
          replacement: const SpinnerLoading(),
          visible: state is! L,
          child: ElevatedButton(onPressed: onTap, child: Text(title)),
        );
      },
    );
  }
}
