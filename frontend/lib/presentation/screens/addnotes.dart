import 'package:digital_notebook/bloc/add_note_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AddNote extends StatelessWidget {

  const AddNote({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<AddNoteBloc>();
    final state = bloc.state;
    if (state is AddNoteInitial){
      bloc.add(InitialEvent());
      return const Scaffold();
    }
    else if(state is AddNoteDefault)
    {
      return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Note',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w300),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFormField(
              controller: state.titleController,
              style: const TextStyle(fontSize: 26, color: Colors.black, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Title",
              ),
              maxLines: null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: state.bodyController,
              style: const TextStyle(fontSize: 18, color: Colors.black),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Enter your note here...",
              ),
              maxLines: null,
            ),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'noteTitle':state.titleController.text,
                  'noteBody':state.bodyController.text
                });
                bloc.add(InitialEvent());
              },
              child: const Text('Save Note'),
            ),
          ]
        ),
      ),
    );}
    else{
      return Scaffold(
        body: Center(
          child: Text('Unimplemented state $state'),
          )
      );
    }
  }
}