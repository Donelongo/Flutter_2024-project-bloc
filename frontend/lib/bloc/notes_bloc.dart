import 'dart:async';
import 'dart:math';

import 'package:digital_notebook/services/notes_api_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:digital_notebook/models/note_model.dart';
import 'package:digital_notebook/shared/db_connection.dart';
part 'notes_event.dart';
part 'notes_state.dart';


class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesApiService apiService;

  NotesBloc(this.apiService) : super(NotesInitial()) {
    on<AddNotes>(_addNotes);
    on<GiveMeData>(_fetchData);
    on<DeleteNotes>(_deleteNotes);
    on<UpdateNotes>(_updateNotes);
  }

  _fetchData(event, emit) async {
    // await Future.delayed(const Duration(seconds: 2));
    emit(NotesLoading());
    try {
      final notes = await apiService.fetchNotes();
      emit(NotesLoaded(notes: notes, notesError: NotesError.none));
    } catch (e) {
      debugPrint("ERROR_FETCHING: ${e.toString()}");
      emit(const NotesLoaded(notes: [], notesError: NotesError.network));
    }
  }



// _addNotes(AddNotes event, emit) async {
//   final userId = await retrieveUserId();
//   if (state is NotesLoaded) {
//     final notesState = state as NotesLoaded;
//     try {
//       final newNote = Note(
//         id: '',
//         title: event.title,
//         content: event.body,
//         userId: '$userId',
//         index: notesState.notes.length,
//         createdAt: DateTime.now(),
//         updatedAt: DateTime.now(),
//       );
//       final addedNote = await apiService.createNote(newNote);
//       final updatedNotes = List.of(notesState.notes)..add(addedNote);
//       emit(NotesLoaded(notes: updatedNotes, notesError: NotesError.none));
//     } catch (e) {
//       debugPrint("ERROR_CREATING: ${e.toString()}");
//       emit(NotesLoaded(notes: notesState.notes, notesError: NotesError.network));
//     }
//   }
// }

String generateRandomAlphanumericPlaceholder(int length) {
  const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Random rnd = Random();
  return String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
}

  _addNotes(AddNotes event, emit) async {
  final userId = await retrieveUserId();
  if (state is NotesLoaded) {
    final notesState = state as NotesLoaded;
    final completer = Completer<void>();
    final idPh = generateRandomAlphanumericPlaceholder(24);
    debugPrint('ID: $idPh');
    try {
      final newNote = Note(
        id: idPh,
        title: event.title,
        content: event.body,
        userId: '$userId',
        index: notesState.notes.length,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final addedNote = await apiService.createNote(newNote);
      final updatedNotes = List.of(notesState.notes)..add(addedNote);
      emit(NotesLoaded(notes: updatedNotes, notesError: NotesError.none));
      completer.complete();
    } catch (e) {
      debugPrint("ERROR_CREATING: ${e.toString()}");
      emit(NotesLoaded(notes: notesState.notes, notesError: NotesError.network));
      completer.completeError(e);
    }
  }
}

  _deleteNotes(DeleteNotes event, emit) async {
    if (state is NotesLoaded) {
      final notesState = state as NotesLoaded;
      // final completer = Completer<void>();
      try {
        if (event.index >= 0 && event.index < notesState.notes.length) {
          debugPrint('Event Triggered');
          String noteId = notesState.notes[event.index].id;
          debugPrint('Note ID: $noteId');
          debugPrint(notesState.notes.toString());
          await apiService.deleteNote(noteId);
          // Now you can proceed with your delete operation
        } else {
          debugPrint('Note does not exist');
}
        final updatedNotes = List.of(notesState.notes)..removeAt(event.index);
        emit(NotesLoaded(notes: updatedNotes, notesError: NotesError.none));
        // completer.complete();
      } catch (e) {
        debugPrint("ERROR_DELETING: ${e.toString()}");
        emit(NotesLoaded(notes: notesState.notes, notesError: NotesError.network));
        // completer.completeError(e);
      }
    }
  }

  _updateNotes(UpdateNotes event, emit) async {
    if (state is NotesLoaded) { //dont think this is the correct state... this is for when we edit a note like in here malet new
      final notesState = state as NotesLoaded;
      try {
        final updatedNote = Note(
          id: notesState.notes[event.index].id,
          title: event.title,
          content: event.body,
          userId: notesState.notes[event.index].userId,
          index: event.givenIndex,
          createdAt: notesState.notes[event.index].createdAt,
          updatedAt: DateTime.now(),
        );
        await apiService.updateNote(updatedNote.id, updatedNote);
        final updatedNotes = List.of(notesState.notes)
          ..removeAt(event.index)
          ..insert(event.index, updatedNote);
        emit(NotesLoaded(notes: updatedNotes, notesError: NotesError.none));
      } catch (e) {
        emit(NotesLoaded(notes: notesState.notes, notesError: NotesError.network));
      }
    }
  }
}