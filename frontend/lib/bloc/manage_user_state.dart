part of 'manage_user_bloc.dart';

abstract class ManageUsersState extends Equatable {
  final List<User> users;

  const ManageUsersState(this.users);

  @override
  List<Object> get props => [users];
}

class UsersInitial extends ManageUsersState {
  const UsersInitial(List<User> users) : super(users);
}

class UsersLoaded extends ManageUsersState {
  const UsersLoaded(List<User> users) : super(users);
}