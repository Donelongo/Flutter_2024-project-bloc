import 'package:flutter/material.dart';

class CircleAvatarWidget extends StatelessWidget {
  final String routeName;

  const CircleAvatarWidget({super.key, required this.routeName});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem<String>(
            value: 'update Profile',
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
        if (value == 'update Profile') {
          Navigator.pushNamed(context, '/updateProfile');
        } else if (value == 'delete Account') {
          // Handle delete account logic here
        } else if (value == 'logout') {
          Navigator.pushNamed(context, routeName);
        }
      },
      child: const CircleAvatar(
        backgroundImage: AssetImage('assets/images/avatar.png'),
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digital_notebook/bloc/profile_bloc.dart';
import 'package:digital_notebook/bloc/profile_state.dart';

class CircleAvatarWidget extends StatelessWidget {
  final String routeName;

  const CircleAvatarWidget({Key? key, required this.routeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.png'),
            ),
            const SizedBox(width: 8), // Add spacing between avatar and text
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                    value: 'update Profile',
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
                if (value == 'update Profile') {
                  Navigator.pushNamed(context, '/updateProfile');
                } else if (value == 'delete Account') {
                  // Handle delete account logic here
                } else if (value == 'logout') {
                  Navigator.pushNamed(context, routeName);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
 */