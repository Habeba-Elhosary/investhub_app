part of 'edit_profile_cubit.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object?> get props => [];
}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileFailure extends EditProfileState {
  final String message;

  const EditProfileFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class EditProfileSuccess extends EditProfileState {}

class EditProfileStepChanged extends EditProfileState {
  final int step;

  const EditProfileStepChanged(this.step);

  @override
  List<Object?> get props => [step];
}
