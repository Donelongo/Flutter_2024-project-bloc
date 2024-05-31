// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:digital_notebook/shared/base_url.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<RequestPageLoad>(_requestSignupPage);
    on<OnSignupSubmit>(_handleSubmit);
  }

  void _requestSignupPage(
      RequestPageLoad event, Emitter<SignupState> emit) async {
    emit(SignupLoading());
    // await Future.delayed(const Duration(seconds: 2));
    emit(SignupDefault(
      email: TextEditingController(),
      password: TextEditingController(),
      userName: TextEditingController(),
      error: SignupError.none,
    ));
  }

  Future<void> _handleSubmit(
      OnSignupSubmit event, Emitter<SignupState> emit) async {
    if (state is SignupDefault) {
      final signupstate = state as SignupDefault;
      // call the api here
      debugPrint("Signup submit");
      try {
        final response = await http.post(Uri.parse('$baseUrl/users/register'),
        headers: {
          'Content-Type': 'application/json',
        },
            body: jsonEncode({
              "email": signupstate.email.text,
              "password": signupstate.password.text,
              "username": signupstate.userName.text,
            }));
        debugPrint("workkkkkkkkkkkkkkkkkk");
        if (response.statusCode == 201) {
          debugPrint("Success with user signup");
          emit(SignupSuccess());
        } else {
          emit(
            SignupDefault(
              email: TextEditingController(),
              password: TextEditingController(),
              userName: TextEditingController(),
              error: SignupError.input,
            ),
          );
        }
      } catch (e) {
        debugPrint("workkkkkkkkkkkkkkkkkk pleaseeeeeeeeeeeee");
        emit(
          SignupDefault(
            email: TextEditingController(),
            password: TextEditingController(),
            userName: TextEditingController(),
            error: SignupError.input,
          ),
        );
      }
    }
  }
}
