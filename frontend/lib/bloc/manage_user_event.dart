part of 'manage_user_bloc.dart';

abstract class ManageUsersEvent extends Equatable {
  const ManageUsersEvent();

  @override
  List<Object> get props => [];
}

class LoadUsers extends ManageUsersEvent {}

class AddUser extends ManageUsersEvent {
  final User user;

  const AddUser(this.user);

  @override
  List<Object> get props => [user];
}

class DeleteUser extends ManageUsersEvent {
  final String userId;

  const DeleteUser(this.userId);

  @override
  List<Object> get props => [userId];
}

class UpdateUser extends ManageUsersEvent {
  final User updatedUser;

  const UpdateUser(this.updatedUser);

  @override
  List<Object> get props => [updatedUser];
}