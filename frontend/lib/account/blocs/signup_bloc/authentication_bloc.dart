// authentication_bloc.dart
// ignore_for_file: depend_on_referenced_packages, unrelated_type_equality_checks, unused_element

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<LoginSubmit>(_handleAuthentication);
    on<RequestPageLoad>(_handleRequestPageLoad);
    on<AccountCreation>(_handleAccountCreation);
  }

  _handleAuthentication(event, emit) {
  if (state is AuthenticationDefault) {
    final authState = state as AuthenticationDefault;
    // Have a dummy login info
    const String dummyEmail = "a@a.com";
    const String dummyPassword = "12345678";

    final actualEmail = authState.email.text; // Get the email string
    final actualPassword = authState.password.text;

            debugPrint('this is the debug orint.......................111111..');

      if (actualEmail == dummyEmail && actualPassword == dummyPassword) {
        debugPrint('this is the debug orint.........................');
        emit(AuthenticationSuccess());
      } else {
        emit(AuthenticationDefault(
            email: TextEditingController(),
            password: TextEditingController(),

            error: AuthenticationError.Input));
      }

  }
}


  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  _handleRequestPageLoad(event, emit) async {
    emit(PageLoading());
    await Future.delayed(const Duration(seconds: 1));
    emit(AuthenticationDefault(
        email: TextEditingController(),
        password: TextEditingController(),
        error: AuthenticationError.None));
  }

  _handleAccountCreation(event, emit) async {
    emit(PageLoading());
    // Simulate API call or account creation logic
    await Future.delayed(const Duration(seconds: 2));
    // Assuming account creation is always successful for demo purposes
    emit(AuthenticationSuccess());
  }
}
