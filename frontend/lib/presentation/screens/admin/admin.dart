// ignore_for_file: unused_element
import 'package:digital_notebook/presentation/screens/admin/adminNotes.dart';
import 'package:digital_notebook/presentation/widgets/avatar.dart';
import 'package:flutter/material.dart';
import './add_activity_dialog.dart';
import './adminOthers.dart';
import 'package:digital_notebook/models/note_model.dart';
import 'package:digital_notebook/presentation/widgets/note_card.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  AdminPageState createState() => AdminPageState();
}

class AdminPageState extends State<AdminPage>
    with SingleTickerProviderStateMixin {
  List<Activity> activities = [];
  List<Note> notes = List.empty(growable: true);
  TextEditingController activityController = TextEditingController();
  TextEditingController userController = TextEditingController();
  DateTime? _selectedDateTime;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Admin',
              style: TextStyle(
                fontSize: 28,
              ),
            ),
          ),
          actions: const <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: CircleAvatarWidget(
                    key: Key('avatar'),
                    routeName: '/home',
                  ),
                ),
              ),
            ),
          ]),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.builder(
            itemCount: activities.length,
            itemBuilder: (BuildContext context, int index) {
//...........................Activity log starts...............................

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
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _showEditActivityDialog(context, index);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      backgroundColor: Colors.grey[900],
                                      title: const Text(
                                        "Delete Note ?",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      content: Text(
                                        "Activity '${activities[index].user}' will be deleted!",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            _deleteActivity(index);
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Delete"),
                                        ),
                                      ]);
                                });
                          },
                        ),
                        // IconButton(
                        //   icon: const Icon(Icons.delete),
                        //   onPressed: () {
                        //     _deleteActivity(index);
                        //   },
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (activities[index].logs.isNotEmpty) ...[
                    const Text(
                      'Logs:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Column(
                      children: activities[index]
                          .logs
                          .map((log) => Text(
                                log,
                                textAlign: TextAlign.center,
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 8),
                  ],
                  const Divider(),
                ],
              );
            },
          ),

//...........................Activity log Ends...............................

          const AdminNotesPage(),

          ListView.builder(
            itemCount: notes.length,
            itemBuilder: (BuildContext context, int index) {
              return NotesCard(
                note: notes[index],
                index: index,
                onNoteDeleted: onNoteDeleted,
                onNoteEdited: onNoteEdited,
                deleteNote: () {},
                onDataRecieved: (data) {},
              );
            },
          ),

          const AdminOthersPage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/addActivity');
          if (result != null && result is Map) {
            debugPrint(
                'Activity added: ${result['user']}, ${result['activity']}, ${result['dateTime']}');
          }
        },
        backgroundColor: Colors.blueGrey,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),


      bottomNavigationBar: TabBar(
        controller: _tabController,
        tabs: const [
          Tab(
            icon: Icon(Icons.history, color: Colors.blueGrey),
            text: 'History',
          ), // Current page
          Tab(
            icon: Icon(Icons.notes, color: Colors.blueGrey),
            text: 'Notes',
          ), // Notes page
          Tab(
            icon: Icon(Icons.people_alt, color: Colors.blueGrey),
            text: "Other's Notes",
          ), // Other People page
        ],
      ),
    );
  }

  void _showAddActivityDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddActivityDialog(
          userController: userController,
          activityController: activityController,
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
        logs: ['Added at ${DateTime.now()}'],
      ));
    });
  }

  void _showEditActivityDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Activity'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: activities[index].user),
                decoration: const InputDecoration(labelText: 'User'),
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              TextField(
                controller: TextEditingController(text: activities[index].name),
                decoration: const InputDecoration(
                  labelText: 'Activity',
                ),
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _editActivity(
                    index, userController.text, activityController.text);
              },
              child: const Text('Save'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
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
      editedActivity.logs.add('Edited at ${DateTime.now()}');
    });
  }

  void _deleteActivity(int index) {
    setState(() {
      var deletedActivity = activities[index];
      deletedActivity.logs.add('Deleted at ${DateTime.now()}');
      activities.removeAt(index);
    });
  }

  void onNewNoteCreated(Note note) {
    notes.add(note);
    setState(() {});
  }

  void onNoteDeleted(int index) {
    notes.removeAt(index);
    setState(() {});
  }

  void onNoteEdited(Note note) {
    notes[note.index].title = note.title;
    notes[note.index].body = note.body;
    setState(() {});
  }
}

class Activity {
  String user;
  String name;
  String date;
  String time;
  List<String> logs;

  Activity(
      {required this.user,
      required this.name,
      required this.date,
      required this.time,
      this.logs = const []});
}
