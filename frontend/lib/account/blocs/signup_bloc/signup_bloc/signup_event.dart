part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class OnSignupSubmit extends SignupEvent {}

class RequestPageLoad extends SignupEvent {}
