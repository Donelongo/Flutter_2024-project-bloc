import 'dart:convert';

import 'package:digital_notebook/shared/base_url.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:digital_notebook/shared/db_connection.dart';

part 'update_profile_event.dart';
part 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  UpdateProfileBloc() : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      final token = await retrieveToken();
      final userId = await retrieveUserId();

      final response = await http.get(Uri.parse(
          '$baseUrl/users/profile/$userId'),
          headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token!}',
        });
      if (response.statusCode == 200) {
        final user = jsonDecode(response.body);
        emit(ProfileLoaded(user['email'], user['username'], user['password']));
      } else {
        // Handle error
      }
    });//i need t restart the app now and unistall it

    // Try it now...

    on<UpdateEmail>((event, emit) {
      if (state is ProfileLoaded) {
        final currentState = state as ProfileLoaded;
        emit(ProfileUpdated(
            event.email, currentState.username, currentState.password));
      }
    });

    on<UpdateUsername>((event, emit) {
      if (state is ProfileLoaded) {
        final currentState = state as ProfileLoaded;
        emit(ProfileUpdated(
            currentState.email, event.username, currentState.password));
      }
    });

    on<UpdatePassword>((event, emit) {
      if (state is ProfileLoaded) {
        final currentState = state as ProfileLoaded;
        emit(ProfileUpdated(
            currentState.email, currentState.username, event.password));
      }
    });
  }

//   Future<String?> retrieveUserId() async {
//   final db = await openDatabaseConnection();

//   final List<Map<String, dynamic>> maps = await db.query('userId');

//   if (maps.isNotEmpty) {
//     return maps.first['userId'] as String?;
//   }
//   return null;
// }
}
