// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'note_view_event.dart';
part 'note_view_state.dart';

class NoteViewBloc extends Bloc<NoteViewEvent, NoteViewState> {
  NoteViewBloc() : super(NoteViewInitial()) {
    on<EditEvent>((event, emit) {
        emit (NoteViewDefault(titleController: TextEditingController(text: event.title), bodyController: TextEditingController(text: event.body)));
    });

  }
}
