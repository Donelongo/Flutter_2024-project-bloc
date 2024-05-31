part of 'note_view_bloc.dart';

sealed class NoteViewEvent extends Equatable {
  const NoteViewEvent();

  @override
  List<Object> get props => [];
}

final class EditEvent extends NoteViewEvent{
  final String body;
  final String title;

  const EditEvent({required this.body, required this.title});

  @override
  List<Object> get props => [title, body];
}
