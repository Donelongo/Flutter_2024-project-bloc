import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CircleAvatarWidgetAdmin extends StatelessWidget {
  final String routeName;

  const CircleAvatarWidgetAdmin({super.key, required this.routeName});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem<String>(
            value: 'Manage User',
            child: Text('Manage User'),
          ),

          const PopupMenuItem<String>(
            value: 'logout',
            child: Text('Logout'),
          ),
        ];
      },
      onSelected: (String value) {
        if (value == 'Manage User') {
          context.go('/manageUser');
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
