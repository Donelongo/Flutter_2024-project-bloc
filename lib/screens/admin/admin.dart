import 'package:flutter/material.dart';
import './add_activity_dialog.dart';
import './adminOthers.dart';
import './adminNotes.dart';
import 'package:digital_notebook/models/note_model.dart';
import 'package:digital_notebook/widgets/note_card.dart';
import '../../widgets/avatar.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> with SingleTickerProviderStateMixin {
  List<Activity> activities = [];
  TextEditingController _activityController = TextEditingController();
  TextEditingController _userController = TextEditingController();
  DateTime? _selectedDateTime;
  late TabController _tabController; // Define TabController

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // Initialize TabController
    _tabController.addListener(_handleTabSelection); // Add listener for tab selection
  }

  void _handleTabSelection() {
    setState(() {}); // Update the state when a tab is selected
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin', style: TextStyle(fontSize: 25) ,),
      ),
      body: TabBarView(
        controller: _tabController, // Assign TabController to TabBarView
        children: [
          // Current page content (AdminHomePage)
          ListView.builder(
            itemCount: activities.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  ListTile(
                    title: Text(activities[index].name),
                    subtitle: Text(
                      'User: ${activities[index].user}, Date: ${activities[index].date}, Time: ${activities[index].time}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _showEditActivityDialog(context, index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteActivity(index);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  if (activities[index].logs.isNotEmpty) ...[
                    Text(
                      'Logs:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Column(
                      children: activities[index]
                          .logs
                          .map((log) => Text(
                                log,
                                textAlign: TextAlign.center,
                              ))
                          .toList(),
                    ),
                    SizedBox(height: 8),
                  ],
                  Divider(),
                ],
              );
            },
          ),
          // Notes page content
          const AdminNotepage(),
          // Other People page content
          const AdminOthersPage(),
        ],
      ),
      floatingActionButton: _tabController.index == 0 // Show FAB only on the home page
          ? FloatingActionButton(
              onPressed: () {
                _showAddActivityDialog(context);
              }, backgroundColor: Colors.blueGrey,
              child: Icon(Icons.add, color: Colors.white),
            )
          : null,
      bottomNavigationBar: TabBar(
        controller: _tabController, // Assign TabController to TabBar
        tabs: [
          Tab(icon: Icon(Icons.history, color:Colors.blueGrey)), // Current page
          Tab(icon: Icon(Icons.notes, color:Colors.blueGrey)), // Notes page
          Tab(icon: Icon(Icons.people_alt, color:Colors.blueGrey)), // Other People page
        ],
      ),
    );
  }

  void _showAddActivityDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddActivityDialog(
          userController: _userController,
          activityController: _activityController,
          selectedDateTime: _selectedDateTime,
          onAddActivity: (user, activity, dateTime) {
            _addActivity(user, activity, dateTime);
          },
          onCloseDialog: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void _addActivity(String user, String activityName, DateTime dateTime) {
    setState(() {
      activities.add(Activity(
        user: user,
        name: activityName,
        date: '${dateTime.year}-${dateTime.month}-${dateTime.day}',
        time: '${dateTime.hour}:${dateTime.minute}',
        logs: ['Added at ${DateTime.now()}'], // Log entry for adding the activity
      ));
    });
  }

  void _showEditActivityDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Activity'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: activities[index].user),
                decoration: InputDecoration(labelText: 'User'),
              ),
              TextField(
                controller: TextEditingController(text: activities[index].name),
                decoration: InputDecoration(labelText: 'Activity'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _editActivity(index, _userController.text, _activityController.text);
              },
              child: Text('Save'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _editActivity(int index, String newUser, String newName) {
    setState(() {
      var editedActivity = activities[index];
      editedActivity.user = newUser;
      editedActivity.name = newName;
      editedActivity.logs.add('Edited at ${DateTime.now()}'); // Log entry for editing the activity
    });
  }

  void _deleteActivity(int index) {
    setState(() {
      var deletedActivity = activities[index];
      deletedActivity.logs.add('Deleted at ${DateTime.now()}'); // Log entry for deleting the activity
      activities.removeAt(index);
    });
  }
}

class Activity {
  String user;
  String name;
  String date;
  String time;
  List<String> logs;

  Activity({required this.user, required this.name, required this.date, required this.time, this.logs = const []});
}
