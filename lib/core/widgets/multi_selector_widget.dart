// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:motah_provider/core/constant/colors.dart';
// import 'package:motah_provider/core/constant/styles/style.dart';

// // ignore: must_be_immutable
// class DropDownMultiSelect extends StatefulWidget {
//   String selectedValue;
//   final String label;
//   final List<String> dropdownItems;
//   DropDownMultiSelect(
//       {super.key,
//       required this.selectedValue,
//       required this.dropdownItems,
//       required this.label});

//   @override
//   // ignore: library_private_types_in_public_api
//   _DropDownMultiSelectState createState() => _DropDownMultiSelectState();
// }

// ignore_for_file: unnecessary_to_list_in_spreads

// class _DropDownMultiSelectState extends State<DropDownMultiSelect> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: DropdownButtonFormField<String>(
//         isExpanded: true,
//         decoration: InputDecoration(
//           labelText: widget.label,
//           labelStyle: TextStyles.textViewRegular15.copyWith(color: titleColor),
//           //  alignLabelWithHint: false,
//           floatingLabelBehavior: FloatingLabelBehavior.always,
//           floatingLabelStyle:
//               TextStyles.textViewRegular15.copyWith(color: titleColor),
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8.r),
//             borderSide: const BorderSide(
//               color: mainColor,
//               width: 1,
//             ),
//           ),
//           disabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8.r),
//             borderSide: const BorderSide(
//               color: greyBG,
//               width: 1,
//             ),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8.r),
//             borderSide: const BorderSide(
//               color: greyBG,
//               width: 1,
//             ),
//           ),
//           focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8.r),
//               borderSide: const BorderSide(
//                 color: red,
//                 width: 1,
//                 style: BorderStyle.solid,
//               )),
//         ),
//         value: widget.selectedValue,
//         borderRadius: BorderRadius.circular(10.r),
//         icon: const Icon(
//           Icons.expand_more,
//           color: titleColor,
//         ),
//         iconSize: 30,
//         elevation: 16,
//         style: const TextStyle(color: textColor),
//         onChanged: (String? newValue) {
//           setState(() {
//             widget.selectedValue = newValue!;
//           });
//         },
//         items:
//             widget.dropdownItems.map<DropdownMenuItem<String>>((String value) {
//           return DropdownMenuItem<String>(
//             value: value,
//             child: Text(value),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
import 'package:investhub_app/core/entities/base_selectable_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import '../../injection_container.dart';
import '../constant/values/colors.dart';
import '../constant/values/text_styles.dart';

class _TheState {}

Injected<_TheState> _theState = RM.inject(() => _TheState());

class RowWrapper extends InheritedWidget {
  final dynamic data;
  final bool Function() shouldNotify;
  const RowWrapper({
    super.key,
    required super.child,
    this.data,
    required this.shouldNotify,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

class _SelectRow extends StatelessWidget {
  final Function(bool) onChange;
  final bool selected;
  final String text;

  const _SelectRow({
    required this.onChange,
    required this.selected,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChange(!selected);
        _theState.notify();
      },
      child: SizedBox(
        height: kMinInteractiveDimension,
        child: Row(
          children: <Widget>[
            Checkbox.adaptive(
              value: selected,
              onChanged: (bool? x) {
                onChange(x!);
                _theState.notify();
              },
            ),
            Text(text, style: TextStyles.bold14),
          ],
        ),
      ),
    );
  }
}

///
/// A Dropdown multiselect menu
///
///
class DropDownMultiSelect<T extends BaseSelectableEntity>
    extends StatefulWidget {
  /// The options form which a user can select
  final List<T> options;

  /// Selected Values
  final List<T> selectedValues;

  /// This function is called whenever a value changes
  final Function(List<T>) onChanged;

  /// defines whether the field is dense
  final bool isDense;

  /// defines whether the widget is enabled;
  final bool enabled;

  /// Input decoration
  final InputDecoration? decoration;

  /// this text is shown when there is no selection
  final String? whenEmpty;

  /// a function to build custom childern
  final Widget Function(List<T> selectedValues)? childBuilder;

  /// a function to build custom menu items
  final Widget Function(T option)? menuItembuilder;

  /// a function to validate
  final String? Function(T? selectedOptions)? validator;

  /// defines whether the widget is read-only
  final bool readOnly;

  /// icon shown on the right side of the field
  final Widget? icon;

  /// Textstyle for the hint
  final TextStyle? hintStyle;

  /// hint to be shown when there's nothing else to be shown
  final Widget? hint;
  final String label;

  /// style for the selected values
  final TextStyle? selectedValuesStyle;

  const DropDownMultiSelect({
    super.key,
    required this.options,
    required this.selectedValues,
    required this.onChanged,
    required this.label,
    this.whenEmpty,
    this.icon,
    this.hint,
    this.hintStyle,
    this.childBuilder,
    this.selectedValuesStyle,
    this.menuItembuilder,
    this.isDense = true,
    this.enabled = true,
    this.decoration,
    this.validator,
    this.readOnly = false,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DropDownMultiSelectState createState() => _DropDownMultiSelectState<T>();
}

class _DropDownMultiSelectState<TState extends BaseSelectableEntity>
    extends State<DropDownMultiSelect<TState>> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          DropdownButtonFormField<TState>(
            hint: widget.hint,
            style: widget.hintStyle,
            icon: Icon(Icons.expand_more, color: AppColors.primary),
            validator: widget.validator,
            decoration: InputDecoration(
              labelText: widget.label,
              // labelStyle: TextStyles.regular16.copyWith(color: AppColors.grey),
              //  alignLabelWithHint: false,
              // floatingLabelBehavior: FloatingLabelBehavior.always,
              // floatingLabelStyle:
              //     TextStyles.regular16.copyWith(color: AppColors.primary),
              // contentPadding:
              //     const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              // focusedBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(8.r),
              //   borderSide: const BorderSide(
              //     color: primary,
              //     width: 1,
              //   ),
              // ),
              // disabledBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(8.r),
              //   borderSide: const BorderSide(
              //     color: greyBG,
              //     width: 1,
              //   ),
              // ),
              // enabledBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(8.r),
              //   borderSide: const BorderSide(
              //     color: greyBG,
              //     width: 1,
              //   ),
              // ),
              // focusedErrorBorder: OutlineInputBorder(
              //     borderRadius: BorderRadius.circular(8.r),
              //     borderSide: const BorderSide(
              //       color: red,
              //       width: 1,
              //       style: BorderStyle.solid,
              //     )),
            ),
            isDense: widget.isDense,
            onChanged: widget.enabled ? (Object? x) {} : null,
            isExpanded: false,
            value: widget.selectedValues.isNotEmpty
                ? widget.selectedValues[0]
                : null,
            selectedItemBuilder: (BuildContext context) {
              return widget.options
                  .map((Object? e) => DropdownMenuItem(child: Container()))
                  .toList();
            },
            items: <DropdownMenuItem<TState>>[
              ...widget.options
                  .map(
                    (TState x) => DropdownMenuItem<TState>(
                      value: x,
                      onTap: !widget.readOnly
                          ? () {
                              if (widget.selectedValues.contains(x)) {
                                List<TState> ns = widget.selectedValues;
                                ns.remove(x);
                                widget.onChanged(ns);
                              } else {
                                List<TState> ns = widget.selectedValues;
                                ns.add(x);
                                widget.onChanged(ns);
                              }
                            }
                          : null,
                      child: _theState.rebuild(() {
                        return _SelectRow(
                          selected: widget.selectedValues.contains(x),
                          text: x.value,
                          onChange: (bool isSelected) {
                            if (isSelected) {
                              List<TState> ns = widget.selectedValues;
                              ns.add(x);
                              widget.onChanged(ns);
                            } else {
                              List<TState> ns = widget.selectedValues;
                              ns.remove(x);
                              widget.onChanged(ns);
                            }
                            setState(() {});
                          },
                        );
                      }),
                    ),
                  )
                  .toList(),
              DropdownMenuItem<TState>(
                enabled: false,
                alignment: Alignment.bottomCenter,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    appNavigator.pop();
                  },
                  child: Text(
                    tr('save'),
                    style: TextStyles.bold16.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Container(
            alignment: context.locale.languageCode == 'ar'
                ? Alignment.centerRight
                : Alignment.centerLeft,
            padding: EdgeInsets.only(
              left: context.locale.languageCode == 'ar' ? 50.w : 16.w,
              right: context.locale.languageCode == 'en' ? 50.w : 16.w,
            ),
            height: 40.h,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              // reverse: true,
              child: widget.childBuilder != null
                  ? widget.childBuilder!(widget.selectedValues)
                  : Text(
                      widget.selectedValues.isNotEmpty
                          ? widget.selectedValues
                                .map((TState e) => e.value)
                                .reduce((Object? a, Object? b) => '$a, $b')
                          : widget.whenEmpty ?? '',
                      style: TextStyles.regular14,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
