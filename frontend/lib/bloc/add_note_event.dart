part of 'add_note_bloc.dart';

sealed class AddNoteEvent extends Equatable {
  const AddNoteEvent();

  @override
  List<Object> get props => [];
}

final class InitialEvent extends AddNoteEvent{}
final class ResetEvent extends AddNoteEvent{}