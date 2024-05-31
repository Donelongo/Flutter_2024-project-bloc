import 'package:digital_notebook/bloc/activity_log_bloc.dart';
import 'package:digital_notebook/bloc/activity_log_event.dart';
import 'package:digital_notebook/bloc/activity_log_state.dart';
import 'package:digital_notebook/models/activity_model.dart';
import 'package:digital_notebook/presentation/screens/admin/adminNotes.dart';
import 'package:digital_notebook/presentation/widgets/avatar_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
                  child: CircleAvatarWidgetAdmin(
                    key: Key('avatar'),
                    routeName: '/',
                  ),
                ),
              ),
            ),
          ]),
      body: TabBarView(
        controller: _tabController,
        children: [
          ActivityLogScreen(
            userController: TextEditingController(),
            activityController: TextEditingController(),
          ),
          const AdminNotesPage(),
          const AdminOthersPage(),
        ],
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

  // void _showAddActivityDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AddActivityDialog(
  //         userController: TextEditingController(),
  //         activityController: TextEditingController(),
  //         selectedDateTime: DateTime.now(),
  //         selectedDateTimeNotifier: ValueNotifier<DateTime?>(DateTime.now()),
  //       );
  //     },
  //   );
  // }

  // void _addActivity(String user, String activityName, DateTime dateTime) {
  //   setState(() {
  //     activities.add(Activity(
  //       user: user,
  //       name: activityName,
  //       date: '${dateTime.year}-${dateTime.month}-${dateTime.day}',
  //       time: '${dateTime.hour}:${dateTime.minute}',
  //       logs: ['Added at ${DateTime.now()}'],
  //     ));
  //   });
  // }

  void onNewNoteCreated(Note note) {
    notes.add(note);
    setState(() {});

    // void onNoteDeleted(int index) {
    //   notes.removeAt(index);
    //   setState(() {});
    // }

    // void onNoteEdited(Note note) {
    //   notes[note.index].title = note.title;
    //   notes[note.index].body = note.body;
    //   setState(() {});
    // }
  }
}


class ActivityLogScreen extends StatelessWidget {
  const ActivityLogScreen({
    super.key,
    required this.userController,
    required this.activityController,
  });
  final TextEditingController userController;
  final TextEditingController activityController;

  Future<Map<String, dynamic>?> _showAddActivityDialog(
      BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddActivityDialog(
          userController: TextEditingController(),
          activityController: TextEditingController(),
          selectedDateTime: DateTime.now(),
          selectedDateTimeNotifier: ValueNotifier<DateTime?>(DateTime.now()),
        );
      },
    ) as Map<String, dynamic>?;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ActivityLogBloc>();

    return BlocBuilder<ActivityLogBloc, ActivityLogState>(
      builder: (context, state) {
        if (state is ActivitiesLogInitial) {
          bloc.add(LoadActivitiesEvent());
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ActivitiesLoading) {
          return const NotesLoadingWidget();
        } else if (state is ActivitiesLoaded) {
          final activities = state.activities;

          return Scaffold(
              body: ListView.builder(
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
                              icon: const Icon(Icons.edit),
                              onPressed: () async {
                                final res = await _showEditActivityDialog(context, index, activities, bloc);

                                if(res != null) {
                                  debugPrint('Activity edited: ${res['user']}, ${res['activity']}');
                                  debugPrint("-===============================================================================================");
                                  bloc.add(UpdateActivityEvent(activityId: index, user: res['user'], activity: res['activity'], dateTime: DateTime.now()));
                                }
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
                                                context.pop();
                                              },
                                              child: const Text("Cancel"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                bloc.add(DeleteActivityEvent(activityId: index));
                                                context.pop();
                                              },
                                              child: const Text("Delete"),
                                            ),
                                          ]);
                                    });
                              },
                            ),
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
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  debugPrint("Add Activity button pressed AHHHHHHH");
                  final result = await _showAddActivityDialog(context);
                  if (result != null) {
                    debugPrint(
                        'Activity added: ${result['user']}, ${result['activity']}, ${result['dateTime']}');
                        bloc.add(AddActivityEvent(
                          user: result['user'],
                          activity: result['activity'],
                          dateTime: result['dateTime'],
                        ));
                  }
                },
                backgroundColor: Colors.blueGrey,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ));
        } else {
          return const Center(
            child: Text('Error loading activities'),
          );
        }
      },
    );
  }

  Future<Map<String, dynamic>?>_showEditActivityDialog(BuildContext context, int index, List<Activity> activities, ActivityLogBloc bloc) {
    final TextEditingController editedUserController = TextEditingController(text: activities[index].user);
    final TextEditingController editedActivityController = TextEditingController(text: activities[index].name);

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Activity'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: editedUserController,
                decoration: const InputDecoration(labelText: 'User'),
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              TextField(
                controller: editedActivityController,
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
                context.pop({
                  'user': editedUserController.text,
                  'activity': editedActivityController.text,
                });
              },
              child: const Text('Save'),
            ),
            ElevatedButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // void _editActivity(int index, String newUser, String newName) {}

  // void _deleteActivity(int index) {}
}

class AdminLogHistoryPage extends StatelessWidget {
  AdminLogHistoryPage({super.key});
  final List<Note> notes = [];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (BuildContext context, int index) {
        return NotesCard(
          note: notes[index],
          index: index,
          deleteNote: () {},
          onDataRecieved: (data) {},
        );
      },
    );
  }
}