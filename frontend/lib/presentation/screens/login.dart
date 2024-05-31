import 'package:digital_notebook/account/blocs/signup_bloc/authentication_bloc.dart';
import 'package:digital_notebook/presentation/widgets/email.dart';
import 'package:digital_notebook/presentation/widgets/password.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthenticationBloc>();
    bloc.add(RequestPageLoad());
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccess) {
          final user = state.user;
          if (user != null) {
            print(user.username);
            context.go('/notes');
          } else {
            print('User is null');
          }
          context.go('/notes');
        }
      },
      builder: (context, state) {
        if (state is AuthenticationInitial) {
          return const Scaffold(
            body: Center(child: CupertinoActivityIndicator()),
          );
        } else if (state is AuthenticationDefault) {
          return WillPopScope(
            onWillPop: () async {
              context.go('/home');
              return false;
            },
            child: Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(
                          child: Text(
                            'Welcome back, User',
                            style: TextStyle(color: Colors.black, fontSize: 25),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: <TextSpan>[
                                  const TextSpan(
                                    text: "Don't have an account? ",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: 'Register Here',
                                    style: const TextStyle(
                                      color: Colors.blueGrey,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        context.go('/signup');
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        EmailField(email: state.email),
                        const SizedBox(height: 20),
                        PasswordWidget(passwordController: state.password),
                        const SizedBox(height: 20),
                        if (state.error == AuthenticationError.Input)
                          const Text(
                            'Invalid email or password',
                            style: TextStyle(color: Colors.red),
                          ),
                        ElevatedButton(
                          onPressed: () {
                            bloc.add(LoginSubmit());
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(child: CupertinoActivityIndicator()),
          );
        }
      },
    );
  }
}
