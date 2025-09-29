import 'package:investhub_app/core/enums/static_data_enum.dart';
import 'package:investhub_app/core/widgets/app_error_widget.dart';
import 'package:investhub_app/features/general/presentation/cubits/static_data/static_data_cubit.dart';
import 'package:investhub_app/features/profile/presentation/pages/static_data_shimmer.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class StaticScreen extends StatelessWidget {
  final String type;
  final String title;
  const StaticScreen({super.key, required this.type, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: BlocProvider<StaticDataCubit>(
        create: (context) => sl<StaticDataCubit>()..getStaticDataEvent(type),
        child: BlocBuilder<StaticDataCubit, StaticDataState>(
          builder: (context, state) {
            if (state is StaticDataLoading) {
              return StaticDataShimmer();
            }
            if (state is StaticDataError) {
              return Center(
                child: AppErrorWidget(
                  errorMessage: state.message,
                  onRetry: () {
                    context.read<StaticDataCubit>().getStaticDataEvent(
                      getStaticDataTypeString(StaticDataType.about_app),
                    );
                  },
                ),
              );
            }
            if (state is StaticDataLoaded) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 16.sp,
                  right: 16.sp,
                  bottom: 16.sp,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[HtmlWidget(state.data)],
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
