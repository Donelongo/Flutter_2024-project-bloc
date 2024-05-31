import 'package:digital_notebook/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:digital_notebook/presentation/screens/note_view.dart';

class NotesCard extends StatelessWidget {
  const NotesCard({
    super.key,
    required this.note,
    required this.index,
    required this.onNoteDeleted,
    required this.onNoteEdited,
    required this.deleteNote,
    required this.onDataRecieved,
  });

  final Note note;
  final int index;
  final Function(int) onNoteDeleted;
  final Function(Note) onNoteEdited;
  final VoidCallback deleteNote;
  final Function(Map<String, String> data) onDataRecieved;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final result = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NoteView(
              note: note,
              index: index,
              onNoteDeleted: onNoteDeleted,
              onNoteEdited: onNoteEdited,
              Function: (int p1, String p2, String p3) {},
            ),
          ),
        );
        if (result != null && result is Map) {
          Map<String, String> data = result as Map<String, String>;
          onDataRecieved(data);
        }
      },
      child: Card(
        color: Colors.grey[400],
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title,
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    note.body,
                    style: const TextStyle(fontSize: 20),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: deleteNote,
                icon: const Icon(Icons.delete),
                color: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }
}
