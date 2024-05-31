// import 'package:bloc_test/bloc_test.dart';
// import 'package:digital_notebook/account/blocs/signup_bloc/authentication_bloc.dart';
// import 'package:digital_notebook/account/blocs/signup_bloc/authentication_event.dart';
// import 'package:digital_notebook/account/blocs/signup_bloc/authentication_state.dart';

// blocTest<AuthenticationBloc, AuthenticationState>(
//   'emits [AuthenticationLoading, AuthenticationSuccess] when login is successful',
//   build: () => AuthenticationBloc(),
//   act: (bloc) => bloc.add(Login(username: 'admin', password: 'password')),
//   expect: () => [AuthenticationLoading(), AuthenticationSuccess()],
// );