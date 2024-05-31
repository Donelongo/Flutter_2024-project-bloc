import 'package:digital_notebook/bloc/notes_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:digital_notebook/models/note_model.dart';
import 'package:digital_notebook/presentation/widgets/note_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/avatar.dart';
import './others.dart';

class Notepage extends StatefulWidget {
  const Notepage({super.key});

  @override
  State<Notepage> createState() => NotepageState();
}

class NotepageState extends State<Notepage>
    with SingleTickerProviderStateMixin {
  List<Note> notes = List.empty(growable: true);
  late TabController _tabController;

  @override
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<NotesBloc>();
    final state = bloc.state;
    if (state is NotesInitial) {
      bloc.add(GiveMeData());
      return const NotesLoadingWidget();
    } else if (state is NotesLoading) {
      return const NotesLoadingWidget();
    } else if (state is NotesLoaded) {
      return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Notes',
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
                      routeName: '/login',
                    ),
                  ),
                ),
              ),
            ]),
        body: TabBarView(
          controller: _tabController,
          children: [
            ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                return NotesCard(
                  note: state.notes[index],
                  index: index,
                  onNoteDeleted: onNoteDeleted,
                  onNoteEdited: onNoteEdited,
                  deleteNote: () {
                    bloc.add(DeleteNotes(index: index));
                  },
                  onDataRecieved: (data) {
                    bloc.add(UpdateNotes(
                        title: data['editedNoteTitle'] as String,
                        body: data['editedNoteBody'] as String,
                        index: index,
                        givenIndex: state.notes[index].index));
                  },
                );
              },
            ),
            const ViewOtherNotesPage(),
          ],
        ),
        bottomNavigationBar: TabBar(
          controller: _tabController,
          onTap: (index) {
            _tabController.animateTo(index);
          },
          tabs: const [
            Tab(icon: Icon(Icons.notes), text: "Notes"),
            Tab(icon: Icon(Icons.people_alt), text: "Other's Notes"),
          ],
        ),
        floatingActionButton: _tabController.index == 0
            ? FloatingActionButton(
                onPressed: () async {
                  final result = await Navigator.pushNamed(context, '/addNote');
                  debugPrint('i ahve arrivbed here111111111111111111');
                  debugPrint('$result');
                  if (result != null && result is Map) {
                    debugPrint('i ahve arrivbed here');
                    final title = result['noteTitle'];
                    final body = result['noteBody'];
                    debugPrint('$title, $body');
                    bloc.add(AddNotes(title: title, body: body));
                  }
                },
                backgroundColor: Colors.blueGrey,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )
            : null,
      );
    } else {
      return Scaffold(
        body: Center(
          child: Text("unimplemented state $state"),
        ),
      );
    }
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

class NotesLoadingWidget extends StatelessWidget {
  const NotesLoadingWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
