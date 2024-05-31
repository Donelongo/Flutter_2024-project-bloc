part of 'note_view_bloc.dart';

sealed class NoteViewState extends Equatable {
  const NoteViewState();

  @override
  List<Object> get props => [];
}

final class NoteViewInitial extends NoteViewState {}

final class NoteViewDefault extends NoteViewState{
  final TextEditingController titleController;
  final TextEditingController bodyController;

  const NoteViewDefault({required this.titleController, required this.bodyController});

  @override
  List<Object> get props => [titleController, bodyController];
}
