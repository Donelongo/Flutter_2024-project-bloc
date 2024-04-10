import 'package:digital_notebook/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:digital_notebook/screens/note_view.dart';

class NotesCard extends StatelessWidget {
  const NotesCard({super.key, required this.note, required this.index, required this.onNoteDeleted, required this.onNoteEdited});

  final Note note;
  final int index;
  final Function(int) onNoteDeleted;
  final Function(int, String, String) onNoteEdited;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => NoteView(note: note, index: index, onNoteDeleted: onNoteDeleted, onNoteEdited: onNoteEdited,)));
      },
      child: Card(
              color: Colors.grey[900],
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.title,
                      style: const TextStyle(
                        fontSize: 20
                      ),
                  ),
                  const SizedBox(height: 10,),
                  Text(
                      note.body,
                      style: const TextStyle(
                        fontSize: 20
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                  ),
                  ],
                ),
              ),
            ),
    );
  }
}