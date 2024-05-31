// part of 'authentication_bloc.dart';

// abstract class AuthenticationEvent extends Equatable {
//   const AuthenticationEvent();

//   @override
//   List<Object> get props => [];
// }
// class LoginSubmit extends AuthenticationEvent{}

// class RequestPageLoad extends AuthenticationEvent {
//   @override
//   List<Object> get props => [];
// }
// class OnSubmitEvent extends AuthenticationEvent {}

// class AccountCreation extends AuthenticationEvent {}

// class LogoutEvent extends AuthenticationEvent {}



// authentication_event.dart

part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class LoginSubmit extends AuthenticationEvent {}

class RequestPageLoad extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class OnSubmitEvent extends AuthenticationEvent {}

class AccountCreation extends AuthenticationEvent {
  final String email;
  final String password;
  final String username;

  const AccountCreation({
    required this.email,
    required this.password,
    required this.username,
  });

  @override
  List<Object> get props => [email, password, username];
}

class LogoutEvent extends AuthenticationEvent {}
