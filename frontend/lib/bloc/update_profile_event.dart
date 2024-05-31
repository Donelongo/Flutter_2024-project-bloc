part of 'update_profile_bloc.dart';

abstract class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadProfile extends UpdateProfileEvent {}

class UpdateEmail extends UpdateProfileEvent {
  final String email;

  const UpdateEmail(this.email);

  @override
  List<Object> get props => [email];
}

class UpdateUsername extends UpdateProfileEvent {
  final String username;

  const UpdateUsername(this.username);

  @override
  List<Object> get props => [username];
}

class UpdatePassword extends UpdateProfileEvent {
  final String password;

  const UpdatePassword(this.password);

  @override
  List<Object> get props => [password];
}
