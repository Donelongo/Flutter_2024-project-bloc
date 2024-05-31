import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digital_notebook/models/note_model.dart';
import 'package:equatable/equatable.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesInitial()) {
    on<AddNotes>(_addNotes);
    on<GiveMeData>(_fetchData);
    on<DeleteNotes>(_deleteNotes);
    on<UpdateNotes>(_updateNotes);
  }

  _fetchData(event, emit) async {
    emit(NotesLoading());
    await Future.delayed(const Duration(seconds: 2));
    final List<Note> notes = [
      Note(body: 'Helloworld hallp', title: 'this is a title', index: 0),
      Note(body: 'Helloworld noptes', title: 'this is a not a title', index: 1),
      Note(body: 'Helloworld i hate this', title: 'this is a junk', index: 2),
      Note(
          body: 'Helloworld ahhhhhhhhh',
          title: 'this is a not a junk',
          index: 3),
      Note(body: 'Helloworld God damit', title: 'this is a nothing', index: 4),
      Note(
          body: 'Helloworld yea hello',
          title: 'this is a not title and a junk',
          index: 5),
    ];
    emit(NotesLoaded(notes: notes, notesError: NotesError.none));
  }

  _addNotes(AddNotes event, emit) async {
    if (state is NotesLoaded) {
      final notesState = state as NotesLoaded;
      final List<Note> addNotes = List.of(notesState.notes);
      final newNote =
          Note(title: event.title, body: event.body, index: addNotes.length);
      addNotes.add(newNote);
      emit(NotesLoaded(notes: addNotes, notesError: NotesError.none));
    }
  }

  _deleteNotes(DeleteNotes event, emit) async {
    if (state is NotesLoaded) {
      final notesState = state as NotesLoaded;
      final List<Note> deleteNotes = List.of(notesState.notes);
      deleteNotes.removeAt(event.index);
      emit(NotesLoaded(notes: deleteNotes, notesError: NotesError.none));
    }
  }

  _updateNotes(UpdateNotes event, emit) async {
    if (state is NotesLoaded) {
      final notesState = state as NotesLoaded;
      final List<Note> updateNotes = List.of(notesState.notes);
      final Note note = Note(title: event.title, body: event.body, index: event.givenIndex);
      updateNotes.removeAt(event.index);
      updateNotes.insert(event.index, note);

      emit(NotesLoaded(notes: updateNotes, notesError: NotesError.none));
    }
  }
}
