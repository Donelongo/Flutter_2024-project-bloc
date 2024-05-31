part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}
class LoginSubmit extends AuthenticationEvent{}

class RequestPageLoad extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}
class OnSubmitEvent extends AuthenticationEvent {}

class AccountCreation extends AuthenticationEvent {}

class LogoutEvent extends AuthenticationEvent {}