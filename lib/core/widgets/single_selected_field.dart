// ignore_for_file: deprecated_member_use, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:investhub_app/core/constant/values/colors.dart';

class SingleSelectField<
  Cubit extends StateStreamable<CState>,
  CState,
  LoadingState extends CState,
  ErrorState extends CState
>
    extends StatefulWidget {
  final String? prefixSvg;
  final Color? bgColor;
  final String label;
  final List<SelectOption> options;
  final SelectOption? selected;
  final ValueChanged<SelectOption> onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Function() initState;

  const SingleSelectField({
    super.key,
    this.bgColor = AppColors.white,
    required this.label,
    required this.options,
    required this.onChanged,
    this.prefixSvg,
    this.selected,
    required this.controller,
    required this.initState,
    this.validator,
  });

  @override
  State<SingleSelectField<Cubit, CState, LoadingState, ErrorState>>
  createState() =>
      _SingleSelectFieldState<Cubit, CState, LoadingState, ErrorState>();
}

class _SingleSelectFieldState<
  Cubit extends StateStreamable<CState>,
  CState,
  LoadingState extends CState,
  ErrorState extends CState
>
    extends State<SingleSelectField<Cubit, CState, LoadingState, ErrorState>> {
  String? _selected;
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected?.label;
    widget.controller?.text = widget.selected?.label ?? '';
  }

  @override
  void didUpdateWidget(
    covariant SingleSelectField<Cubit, CState, LoadingState, ErrorState>
    oldWidget,
  ) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selected != widget.selected) {
      setState(() => _selected = widget.selected?.label);
      widget.controller?.text = widget.selected?.label ?? '';
    }

    if (oldWidget.options != widget.options) {
      setState(() {
        if (!widget.options.any((o) => o.label == _selected)) {
          _selected = null;
          widget.controller?.clear();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Cubit, CState>(
      listener: (context, state) {
        if (state is LoadingState) {
          setState(() => _selected = null);
        }
      },
      builder: (context, state) {
        Widget suffix;

        if (state is LoadingState) {
          suffix = const UnconstrainedBox(
            child: SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator.adaptive(strokeWidth: 2),
            ),
          );
        } else if (state is ErrorState) {
          suffix = GestureDetector(
            onTap: widget.initState,
            child: const Icon(Icons.refresh, color: Colors.red),
          );
        } else {
          suffix = Icon(
            _expanded
                ? Icons.keyboard_arrow_up_outlined
                : Icons.keyboard_arrow_down_outlined,
            color: AppColors.grey,
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: widget.validator,
              readOnly: true,
              controller: widget.controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: widget.bgColor,
                hintText: widget.label,
                prefixIcon: widget.prefixSvg == null
                    ? null
                    : SvgPicture.asset(
                        widget.prefixSvg!,
                        fit: BoxFit.scaleDown,
                      ),
                suffixIcon: suffix,
              ),
              onTap: state is! LoadingState && state is! ErrorState
                  ? () => setState(() => _expanded = !_expanded)
                  : null,
            ),
            if (_expanded && state is! LoadingState && state is! ErrorState)
              Container(
                padding: EdgeInsets.all(5.sp),
                margin: EdgeInsets.only(top: 5.sp),
                decoration: BoxDecoration(
                  color: widget.bgColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  children: widget.options.map((option) {
                    final isSelected = _selected == option.label;
                    return Container(
                      margin: EdgeInsets.only(bottom: 8.sp),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary.withValues(alpha: 0.1)
                            : AppColors.white,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: RadioListTile<String>(
                        activeColor: AppColors.primary,
                        controlAffinity: ListTileControlAffinity.trailing,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.sp),
                        title: Text(option.label),
                        value: option.label,
                        groupValue: _selected,
                        onChanged: (val) {
                          setState(() {
                            _selected = val;
                            _expanded = false;
                          });
                          widget.controller?.text = option.label;
                          widget.onChanged(option);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
          ],
        );
      },
    );
  }
}

// TODO : ??
class SelectOption {
  final int id;
  final String label;

  const SelectOption({required this.id, required this.label});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectOption &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
