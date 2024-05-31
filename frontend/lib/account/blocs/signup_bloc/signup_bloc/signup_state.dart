part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupDefault extends SignupState {
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController userName;
  final SignupError error;

  const SignupDefault({
    required this.email,
    required this.password,
    required this.userName,
    required this.error,
  });

  @override
  List<Object> get props => [email.text, password.text, error];
}

class SignupSuccess extends SignupState {}

enum SignupError { none, input, network, userNameInput}
