// ignore_for_file: deprecated_member_use, file_names

import 'package:flutter/material.dart';
import 'package:digital_notebook/presentation/widgets/email.dart';
import 'package:digital_notebook/presentation/widgets/password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digital_notebook/account/blocs/signup_bloc/authentication_bloc.dart';

class AdminLoginPage extends StatelessWidget {
  const AdminLoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthenticationBloc>();
    // Doing this so that it wont remember the state it was in when someone logs out or something
    bloc.add(RequestPageLoad());
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state){
            if (state is AuthenticationSuccess) {
                // go to where you want
                Navigator.pushNamed(context, '/admin');
            }
        },

        builder: (context, state) {

        if (state is AuthenticationInitial){
        return const Scaffold(
                body: Center(child: CupertinoActivityIndicator())
                );
        }
        else if(state is AuthenticationDefault){
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, '/home');
        return false;
      },

      child: Scaffold(
          appBar: AppBar(
            title: const Text('Login',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20
            ),
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
                  children: [const Center(child:Text(
                      'Welcome back, Admin',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
              ),
              const SizedBox(height: 20),

                const SizedBox(height: 20),
                    EmailField(email: state.email),
                    const SizedBox(height: 20),
                    PasswordWidget(passwordController: state.password),
                    const SizedBox(height: 20),
                    if (state.error == AuthenticationError.Input)
                      const Text('Invalid email or paswword',
                      style: TextStyle(color:Colors.red),),
                    ElevatedButton(
                      onPressed: () {
                        bloc.add(LoginSubmit());
                      },
                      child: const Text('Login', style:TextStyle(color: Colors.blueGrey)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      );
    }else{
      return const Scaffold(
        body: Center(child: CupertinoActivityIndicator(),),
      );
    }
  }
  );

  }
}
