import 'dart:convert';
import 'package:digital_notebook/shared/base_url.dart';
import 'package:digital_notebook/shared/db_connection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digital_notebook/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

Future<http.Response> loginCheck(String email, String password) async {
  var url = Uri.parse('http://localhost:3000/Enotes/auth/login'); // replace with your backend URL

  var response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  return response;
}

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<LoginSubmit>(_handleAuthentication);
    on<RequestPageLoad>(_handleRequestPageLoad);
    on<AccountCreation>(_handleAccountCreation);
  }

  _handleAuthentication(LoginSubmit event, Emitter<AuthenticationState> emit) async {
  if (state is AuthenticationDefault) {
    final authState = state as AuthenticationDefault;
    final actualEmail = authState.email.text;
    final actualPassword = authState.password.text;

    final response = await http.post(
      Uri.parse('$baseUrl/users/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': actualEmail,
        'password': actualPassword,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseBody = jsonDecode(response.body);
      final user = User.fromJson(responseBody['user']);
      debugPrint("USER_ID: ${user.id}");
      await insertToken(responseBody['access_token'], user.id);
      emit(AuthenticationSuccess(user));
    } else {
      emit(
        AuthenticationDefault(
          email: TextEditingController(),
          password: TextEditingController(),
          error: AuthenticationError.Input)
          );
    }
  }
}

// need to see the backend

Future<void> insertToken(String token, String? userId) async { // Find where the chain is broken so where is it stoping the sending process
  final db = await openDatabaseConnection();
  await db.insert(
    'tokens',
    {'token': token, 'userId': userId},
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

  _handleRequestPageLoad(RequestPageLoad event, Emitter<AuthenticationState> emit) async {
    emit(PageLoading());
    await Future.delayed(const Duration(seconds: 1));
    emit(AuthenticationDefault(
        email: TextEditingController(),
        password: TextEditingController(),
        error: AuthenticationError.None));
  }
  // Dont even know what database it is redering tooo...

  _handleAccountCreation(AccountCreation event, Emitter<AuthenticationState> emit) async {
    emit(PageLoading());
    var response = await http.post(
      Uri.parse('http://localhost:3000/users/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': event.email,
        'password': event.password,
        // 'username': event.username,
      }),
    );

    if (response.statusCode == 201) {
      final responseBody = jsonDecode(response.body);
      final user = User.fromJson(responseBody['user']);
      emit(AuthenticationSuccess(user));
    } else {
      emit(AuthenticationDefault(
          email: TextEditingController(),
          password: TextEditingController(),
          error: AuthenticationError.Input));
    }
  }
}
