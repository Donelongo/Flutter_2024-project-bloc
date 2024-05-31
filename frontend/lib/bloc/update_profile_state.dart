part of 'update_profile_bloc.dart';

abstract class UpdateProfileState extends Equatable {
  const UpdateProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends UpdateProfileState {}

class ProfileLoaded extends UpdateProfileState {
  final String email;
  final String username;
  final String password;

  const ProfileLoaded(this.email, this.username, this.password);

  @override
  List<Object> get props => [email, username, password];
}

class ProfileUpdated extends ProfileLoaded {
  const ProfileUpdated(String email, String username, String password)
      : super(email, username, password);
}
