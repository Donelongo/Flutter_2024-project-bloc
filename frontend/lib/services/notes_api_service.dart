import 'dart:convert';
import 'package:digital_notebook/shared/base_url.dart';
import 'package:digital_notebook/shared/db_connection.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:digital_notebook/models/note_model.dart';

class NotesApiService {

  Future<List<Note>> fetchNotes() async {
    final token = await retrieveToken();
    final userId = await retrieveUserId();

    final response = await http.get(Uri.parse('$baseUrl/notes'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token!}',
      'user-id': '$userId'
      });

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((note) => Note.fromJson(note)).toList();
    } else {
      throw Exception('Failed to load notes');
    }
  }


  Future<Note> createNote(Note note) async {
    final token = await retrieveToken();
    final userId = await retrieveUserId();

    debugPrint("USER_ID_S: $userId");

    final response = await http.post(
      Uri.parse('$baseUrl/notes'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token!}',
        'user-id': '$userId'
        },
      body: jsonEncode(note.toJson()),
    );

    if (response.statusCode == 201) {
      return Note.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create note');
    }
  }

  Future<Note> updateNote(String id, Note note) async {
    final token = await retrieveToken();
    final userId = await retrieveUserId();

    final response = await http.put(
      Uri.parse('$baseUrl/notes/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'user-id' : '$userId',
        'Authorization': 'Bearer ${token!}',
        },
      body: jsonEncode(note.toJson()),
    );

    if (response.statusCode == 200) {
      return Note.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update note');
    }
  }

  Future<void> deleteNote(String id) async {
    final token = await retrieveToken();
    final userId = await retrieveUserId();

    final response = await http.delete(
      Uri.parse('$baseUrl/notes/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'user-id' : '$userId',
        'Authorization': 'Bearer $token',
        },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete note');
    }
  }
}
