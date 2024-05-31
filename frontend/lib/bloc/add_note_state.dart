part of 'add_note_bloc.dart';

sealed class AddNoteState extends Equatable {
  const AddNoteState();

  @override
  List<Object> get props => [];
}
final class AddNoteInitial extends AddNoteState{}

final class AddNoteDefault extends AddNoteState {
  final TextEditingController titleController;
  final TextEditingController bodyController;

  const AddNoteDefault({required this.titleController, required this.bodyController});

  @override
  List<Object> get props => [titleController, bodyController];
}

