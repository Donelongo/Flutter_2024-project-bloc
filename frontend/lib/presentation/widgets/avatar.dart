import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CircleAvatarWidget extends StatelessWidget {
  final String routeName;

  const CircleAvatarWidget({super.key, required this.routeName});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: 'Current Email',
            child: Text(
              'a@a.com',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ),
          const PopupMenuDivider(),
          const PopupMenuItem<String>(
            value: 'Update Profile',
            child: Text('Update Profile'),
          ),
          const PopupMenuItem<String>(
            value: 'delete Account',
            child: Text('Delete Account'),
          ),
          const PopupMenuItem<String>(
            value: 'logout',
            child: Text('Logout'),
          ),
        ];
      },
      onSelected: (String value) {
        if (value == 'Update Profile') {
          context.go('/updateProfile');
        } else if (value == 'delete Account') {
          // Handle delete account logic here
        } else if (value == 'logout') {
          context.go(routeName);
        }
      },
      child: const CircleAvatar(
        backgroundImage: AssetImage('assets/images/avatar.png'),
      ),
    );
  }
}
