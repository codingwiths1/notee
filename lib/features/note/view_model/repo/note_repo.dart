import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:notee/features/note/model/note_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@lazySingleton
class NoteRepo {
  final SupabaseClient client;
  final User? currentuser;

  NoteRepo({required this.client}) : currentuser = client.auth.currentUser;

  /// AUTH USERS
  Future<void> initAuth() async {
    final Session? currentsession =
        Supabase.instance.client.auth.currentSession;

    if (currentsession == null) {
      await Supabase.instance.client.auth.signInAnonymously();
      log("signInAnonymously INITIALIZED");
    }
  }

  /// READ
  Future<List<NoteModel>> fetchNotes(int offset, int limit) async {
    try {
      final list = await client
          .from("notes")
          .select()
          .eq("user_id", currentuser!.id)
          .order("id", ascending: true)
          .range(offset, offset + limit - 1);
      final dataList = List.from(list);
      return dataList.map((json) => NoteModel.fromJson(json)).toList();
    } catch (error) {
      throw Exception('THIS IS FETCH_NOTE ERROR $error');
    }
  }

  /// UPDATE
  Future<void> editnote({
    required int id,
    required String newTitle,
    required String newNote,
  }) async {
    final NoteModel noteModel = NoteModel(
      title: newTitle,
      note: newNote,
      id: id,
    );
    await client.from("notes").update(toJson(noteModel.toJson()));
  }

  /// CREATE
  Future<void> addNote({
    required int id,
    required String newTitle,
    required String newNote,
  }) async {
    final NoteModel noteModel = NoteModel(
      title: newTitle,
      note: newNote,
      id: id,
    );
    await client.from("notes").insert(toJson(noteModel.toJson()));
  }

  /// DELETE
  Future<void> deleteNote({required int id}) async {
    await client.from("notes").delete().eq("id", id);
  }
}
