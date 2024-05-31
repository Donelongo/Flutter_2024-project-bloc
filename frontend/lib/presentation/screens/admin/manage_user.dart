import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:digital_notebook/bloc/manage_user_bloc.dart';

class ManageUsersPage extends StatelessWidget {
  const ManageUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManageUsersBloc()..add(LoadUsers()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Manage Users'),
          actions: [
            IconButton(
              onPressed: () => context.go('/admin'),
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: BlocBuilder<ManageUsersBloc, ManageUsersState>(
          builder: (context, state) {
            if (state is UsersLoaded) {
              if (state.users.isEmpty) {
                return const Center(
                  child: Text('No users'),
                );
              } else {
                return ListView.builder(
                  itemCount: state.users.length,
                  itemBuilder: (_, index) => ListTile(
                    title: Text(state.users[index].email),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () =>
                          _confirmDeleteUser(context, state.users[index].id),
                    ),
                  ),
                );
              }
            } else if (state is UsersInitial) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(child: Text('Error: Unknown state'));
            }
          },
        ),
      ),
    );
  }

  void _confirmDeleteUser(BuildContext parentContext, String userId) {
    showDialog(
      context: parentContext,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete User'),
        content: const Text('Are you sure you want to delete this user?'),
        actions: [
          TextButton(
            onPressed: () {
              // Use parentContext here, which has access to BlocProvider
              parentContext.read<ManageUsersBloc>().add(DeleteUser(userId));
              Navigator.of(dialogContext).pop(); // Close the dialog
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.of(dialogContext).pop(), // Close the dialog
            child: const Text('No'),
          ),
        ],
      ),
    );
  }
}
