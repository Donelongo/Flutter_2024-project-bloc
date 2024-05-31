part of 'notes_bloc.dart';

sealed class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

final class NotesInitial extends NotesState {}
final class NotesLoading extends NotesState {}
final class NotesLoaded extends NotesState {
  final List<Note> notes;
  final NotesError notesError;

  const NotesLoaded({required this.notesError, required this.notes});

  @override
  List<Object> get props => [notesError, notes];
}

enum NotesError{none, network, update}
