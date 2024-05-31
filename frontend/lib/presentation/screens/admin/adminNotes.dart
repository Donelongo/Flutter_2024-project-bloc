// ignore_for_file: file_names

import 'package:digital_notebook/bloc/notes_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:digital_notebook/presentation/widgets/note_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AdminNotesPage extends StatelessWidget {
  const AdminNotesPage({super.key});


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
        body: ListView.builder(
          itemCount: state.notes.length,
          itemBuilder: (context, index) {
            return NotesCard(
              note: state.notes[index],
              index: index,
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
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await context.pushNamed('adminAddNotes');
            debugPrint('i have arrived here');
            debugPrint('$result');
            if (result != null && result is Map) {
              debugPrint('i have arrived here');
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
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: Text("unimplemented state $state"),
        ),
      );
    }
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
