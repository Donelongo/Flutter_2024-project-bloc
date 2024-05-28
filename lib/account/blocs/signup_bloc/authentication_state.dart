// authentication_state.dart

// ignore_for_file: constant_identifier_names

part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {}

class AuthenticationDefault extends AuthenticationState {
  final AuthenticationError error;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController passwordController; // Add this field

  const AuthenticationDefault({
    required this.error,
    required this.email,
    required this.password,
    required this.passwordController, // Add this field
  });

  @override
  List<Object> get props => [email, password, passwordController, error]; // Update props
}

class AuthenticationAccountCreate extends AuthenticationState {}

class PageLoading extends AuthenticationState {}

class PageLoaded extends AuthenticationState {}

enum AuthenticationError { Network, Input, None, InvalidEmailFormat, InvalidCredentials }
