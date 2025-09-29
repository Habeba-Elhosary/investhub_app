import 'package:equatable/equatable.dart';

sealed class BaseSelectableEntity extends Equatable {
  final int id;
  final String value;

  const BaseSelectableEntity({required this.id, required this.value});
  @override
  List<Object> get props => <Object>[id, value];
}
