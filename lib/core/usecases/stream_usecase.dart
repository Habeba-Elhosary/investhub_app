// ignore_for_file: avoid_types_as_parameter_names

import 'package:equatable/equatable.dart';

abstract class StreamUseCase<Type, Params> {
  Stream<Type> call(Params params);
}

class NoParamsStream extends Equatable {
  @override
  List<Object> get props => <Object>[];
}
