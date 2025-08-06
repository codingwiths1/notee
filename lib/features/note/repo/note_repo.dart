import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:notee/features/note/model/note_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class NoteRepo {
  Future<void> initAuth();
  Future<List<NoteModel>> fetchNotes(int offset, int limit);
  Future<void> editnote({
    required int id,
    required String newTitle,
    required String newNote,
  });
  Future<void> addNote({
    required int id,
    required String newTitle,
    required String newNote,
  });
  Future<void> deleteNote({required int id});
}

@Injectable(as: NoteRepo)
class NoteRepoIMpl implements NoteRepo {
  final SupabaseClient client;
  final User? currentuser;

  NoteRepoIMpl({required this.client}) : currentuser = client.auth.currentUser;

  /// AUTH USERS
  @override
  Future<void> initAuth() async {
    final Session? currentsession =
        Supabase.instance.client.auth.currentSession;

    if (currentsession == null) {
      await Supabase.instance.client.auth.signInAnonymously();
      log("signInAnonymously INITIALIZED");
    }
  }

  /// READ
  @override
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
  @override
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
  @override
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
    await client.from("notes").insert(noteModel.toJson());
  }

  /// DELETE
  @override
  Future<void> deleteNote({required int id}) async {
    await client.from("notes").delete().eq("id", id);
  }
}
