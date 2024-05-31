// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<RequestPageLoad>(_requestSignupPage);
    on<OnSignupSubmit>(_handleSubmit);
  }

  void _requestSignupPage(RequestPageLoad event, Emitter<SignupState> emit)async {
    emit(SignupLoading());
    await Future.delayed(const Duration(seconds: 2));    emit(SignupDefault(
      email: TextEditingController(),
      password: TextEditingController(),
      userName: TextEditingController(),
      error: SignupError.none,
    ));
  }

  Future<void> _handleSubmit(
      OnSignupSubmit event, Emitter<SignupState> emit) async {
    if(state is SignupDefault){
      final signupstate = state as SignupDefault;
    // call the api here
    await Future.delayed(const Duration(seconds: 2));
    debugPrint('User is being registered ${signupstate.email.text}');
    debugPrint('User is being registered ${signupstate.userName.text}');
    debugPrint('User is being registered ${signupstate.password.text}');


    bool successfullyRegisteredUser = signupstate.userName.text != 'Hello';
    bool hasSameEmail = signupstate.email.text == 'a@a.a';

    if (successfullyRegisteredUser && !hasSameEmail) {
      emit(SignupSuccess());
    } else if (hasSameEmail){
      emit(
        SignupDefault(
          email: TextEditingController(),
          password: TextEditingController(),
          userName: TextEditingController(),
          error: SignupError.input,
        ),
      );
    }
    else{
      emit(
        SignupDefault(
          email: TextEditingController(),
          password: TextEditingController(),
          userName: TextEditingController(),
          error: SignupError.userNameInput,
        ),
      );
    }
    }
  }
}
