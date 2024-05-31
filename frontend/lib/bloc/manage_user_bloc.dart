import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digital_notebook/models/user_model.dart'; // Import your User model
import 'package:equatable/equatable.dart';

part 'manage_user_event.dart';
part 'manage_user_state.dart';

List<User> _dummyUsers = [
  User(id: '1', email: 'user1@example.com', username: 'user1', ),// add password: 'password1' to each user
  User(id: '2', email: 'user2@example.com', username: 'user2', ),
  User(id: '3', email: 'user3@example.com', username: 'user3', ),
];

class ManageUsersBloc extends Bloc<ManageUsersEvent, ManageUsersState> {
  ManageUsersBloc() : super(UsersInitial(_dummyUsers)) {
    on<LoadUsers>((event, emit) async {
      // Simulate a network delay
      // await Future.delayed(const Duration(seconds: 2));
      emit(UsersLoaded(_dummyUsers));
    });

    on<AddUser>((event, emit) {
      emit(UsersLoaded([...state.users, event.user]));
    });

    on<DeleteUser>((event, emit) {
      emit(UsersLoaded(
          state.users.where((user) => user.id != event.userId).toList()));
    });

    on<UpdateUser>((event, emit) {
      final index =
          state.users.indexWhere((user) => user.id == event.updatedUser.id);
      if (index != -1) {
        final updatedUsers = List<User>.from(state.users);
        updatedUsers[index] = event.updatedUser;
        emit(UsersLoaded(updatedUsers));
      }
    });
  }
}