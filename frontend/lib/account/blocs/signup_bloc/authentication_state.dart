// // authentication_state.dart

// // ignore_for_file: constant_identifier_names

// part of 'authentication_bloc.dart';

// abstract class AuthenticationState extends Equatable {
//   const AuthenticationState();

//   @override
//   List<Object> get props => [];
// }

// class AuthenticationInitial extends AuthenticationState {}

// class AuthenticationSuccess extends AuthenticationState {}

// class AuthenticationDefault extends AuthenticationState {
//   final AuthenticationError error;
//   final TextEditingController email;
//   final TextEditingController password;

//   const AuthenticationDefault({
//     required this.error,
//     required this.email,
//     required this.password,
//   });

//   @override
//   List<Object> get props => [email, password, error]; // Update props
// }

// class AuthenticationAccountCreate extends AuthenticationState {}

// class PageLoading extends AuthenticationState {}

// class PageLoaded extends AuthenticationState {}

// enum AuthenticationError { Network, Input, None, InvalidEmailFormat, InvalidCredentials }



// authentication_state.dart




part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final User? user;

  const AuthenticationSuccess(this.user);

  @override
  List<Object> get props => [user ?? ''];
}

class AuthenticationDefault extends AuthenticationState {
  final TextEditingController email;
  final TextEditingController password;
  final AuthenticationError error;

  const AuthenticationDefault({
    required this.email,
    required this.password,
    required this.error,
  });

  @override
  List<Object> get props => [email, password, error];
}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationFailure extends AuthenticationState {
  final String error;

  const AuthenticationFailure(this.error);

  @override
  List<Object> get props => [error];
}

class PageLoading extends AuthenticationState {}

class PageLoaded extends AuthenticationState {}

enum AuthenticationError { Network, Input, None, InvalidEmailFormat, InvalidCredentials }
