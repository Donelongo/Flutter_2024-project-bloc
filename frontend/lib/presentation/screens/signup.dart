// ignore_for_file: deprecated_member_use

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../widgets/password.dart';
import '../widgets/email.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:digital_notebook/account/blocs/signup_bloc/signup_bloc/signup_bloc.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  Widget loadingPage() {
    return const Scaffold(
        body: Center(
      child: CupertinoActivityIndicator(),
    ));
  }

@override
Widget build(BuildContext context) {
  final bloc = context.read<SignupBloc>();
  return WillPopScope(
    onWillPop: () async {
      Navigator.pushNamed(context, '/home');
      return false;
    },
  child: BlocConsumer<SignupBloc, SignupState>(
      listener: (context, state) {

        if (state is SignupSuccess) {
          // Navigate to another page here
          Navigator.pushNamed(context, '/login');
        }
      },
      builder: (context, state) {
        if (state is SignupInitial) {
          bloc.add(RequestPageLoad());
          return loadingPage();
        }
        else if (state is SignupLoading){
          return loadingPage();
          }

        else if (state is SignupDefault) {
              return Scaffold(
                appBar: AppBar(),
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
                              'Welcome, New User',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              ),
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
                                      text: "Already have an account? ",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Sign in Here',
                                      style: const TextStyle(
                                        color: Colors.blueGrey,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushNamed(
                                              context, '/login');
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          EmailField(email: state.email),
                          const SizedBox(height: 10),
                          TextField(
                            controller: state.userName,
                            decoration: const InputDecoration(
                              labelText: 'User Name',
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey),
                              ),
                            ),
                            style: const TextStyle(
                              fontFamily: 'San Serif',
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          PasswordWidget(passwordController: state.password),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              final bloc = context.read<SignupBloc>();
                              bloc.add(OnSignupSubmit());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontFamily: 'San Serif',
                              ),
                            ),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.blueGrey),
                            ),
                          ),
                          if (state.error == SignupError.input)
                            const Text(
                              'An account has already been registered with this email',
                              style: TextStyle(color: Colors.red),
                            ),
                            if (state.error == SignupError.userNameInput)
                            const Text(
                              'Username already taken',
                              style: TextStyle(color: Colors.red),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else if (state is SignupSuccess) {
              return const Scaffold(
                body: Center(
                    child: Text("Signing up success routing to login page")),
              );
            } else {
              return Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "Unimplemented state $state.. Implement state in signup_state.dart.",
                      ),
                    ),
                    const Center(
                      child: Text(
                          "Make sure to also write a condition in signup.dart to render the ui"),
                    )
                  ],
                ),
              );
            }
          },
        ),
  );
  }
}
