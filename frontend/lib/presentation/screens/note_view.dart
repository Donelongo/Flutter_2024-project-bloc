import 'package:digital_notebook/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:digital_notebook/bloc/note_view_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteView extends StatelessWidget {
  final Note note;
  final int index;
  final Function(Note) onNoteEdited;
  final Function(int) onNoteDeleted;

  const NoteView(
      // ignore: non_constant_identifier_names
      {super.key,
      required this.note,
      required this.index,
      required this.onNoteEdited,
      required this.onNoteDeleted,
      // ignore: non_constant_identifier_names
      required Function(int p1, String p2, String p3) Function});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<NoteViewBloc>();
    final state = bloc.state;
    if (state is NoteViewInitial) {
      bloc.add(EditEvent(title: note.title, body: note.body));
      return const Scaffold();
    } else if (state is NoteViewDefault) {
      return Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: state.titleController,
            style: const TextStyle(fontSize: 30.0, color: Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Title',
              hintStyle: TextStyle(color: Colors.white.withAlpha(120)),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                Navigator.pop(context, {
                  'editedNoteTitle': state.titleController.text,
                  'editedNoteBody': state.bodyController.text
                });
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: state.bodyController,
                style: const TextStyle(fontSize: 20, color: Colors.black),
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: "Note",
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
          body: Center(
        child: Text('Unimplemented state $state'),
      ));
    }
  }
}
