// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'add_note_event.dart';
part 'add_note_state.dart';

class AddNoteBloc extends Bloc<AddNoteEvent, AddNoteState> {
  AddNoteBloc() : super(AddNoteInitial()) {
    on<InitialEvent>((event, emit) {
      emit (AddNoteDefault(titleController: TextEditingController(), bodyController: TextEditingController()));
    });
    on<ResetEvent>((event, emit) {
      emit (AddNoteDefault(titleController: TextEditingController(), bodyController: TextEditingController()));
    });
  }
}
