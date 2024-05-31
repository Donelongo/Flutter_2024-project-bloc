part of 'notes_bloc.dart';

sealed class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

final class GiveMeData extends NotesEvent {}

final class AddNotes extends NotesEvent {
  final String title;
  final String body;

  const AddNotes({required this.title, required this.body});

  @override
  List<Object> get props => [title, body];
}

final class DeleteNotes extends NotesEvent {
  final int index;

  const DeleteNotes({
    required this.index,
  });

  @override
  List<Object> get props => [index];
}

final class UpdateNotes extends NotesEvent {
  final String title;
  final String body;
  final int index;
  final int givenIndex;

  const UpdateNotes({
    required this.title,
    required this.body,
    required this.index,
    required this.givenIndex,
  });

  @override
  List<Object> get props => [title, body, index, givenIndex];
}
