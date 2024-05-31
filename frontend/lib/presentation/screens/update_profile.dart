// ignore_for_file: deprecated_member_use

import 'package:digital_notebook/bloc/update_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UpdateProfilePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  UpdateProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateProfileBloc()..add(LoadProfile()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Update Profile'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/notes'),
          ),
        ),
        body: BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (state is ProfileLoaded)
                      Text('Current Email: ${(state).email}'),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Username'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        context
                            .read<UpdateProfileBloc>()
                            .add(UpdateUsername(value));
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        context
                            .read<UpdateProfileBloc>()
                            .add(UpdateEmail(value));
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        context
                            .read<UpdateProfileBloc>()
                            .add(UpdatePassword(value));
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Optionally handle form submission
                        }
                      },
                      child: const Text('Save Changes'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
