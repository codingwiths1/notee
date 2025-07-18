import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notee/features/note/presentation/note_bloc/note_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit()
    : super(
        NoteState(
          loadmore: false,
          notelist: [],
          loading: false,
          delete: false,
          loadingnotes: false,
        ),
      );

  final User? currentuser = Supabase.instance.client.auth.currentUser;
  int offset = 0;
  static const int limit = 3;

  /// AUTH USERS
  Future<void> initAuth() async {
    final Session? currentsession =
        Supabase.instance.client.auth.currentSession;

    if (currentsession == null) {
      await Supabase.instance.client.auth.signInAnonymously();
    }
    log("signInAnonymously INITIALIZED");
  }

  /// FETCH NOTES FROM SUPABASE
  Future<void> fetchnotes({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        offset = 0;
        emit(state.copyWith(notelist: []));
      }
      // updateloaders(loadingnotes: true);
      final List<Map<String, dynamic>> list = await Supabase.instance.client
          .from("notes")
          .select()
          .eq("user_id", currentuser!.id)
          .order("id", ascending: true)
          .range(offset, offset + limit - 1);
      offset += limit;

      emit(state.copyWith(notelist: [...state.notelist, ...list]));
    } catch (e) {
      log("ERROR");
    } finally {
      updateloaders(loadingnotes: false);
    }
  }

  Future<void> loadmore() async {
    emit(state.copyWith(loadmore: true));
    await fetchnotes();
    emit(state.copyWith(loadmore: false));
  }

  /// LOADING VARIABLES
  void updateloaders({
    bool? loading,
    bool? delete,
    bool? loadingnotes,
    bool? loadmore,
  }) {
    emit(
      state.copyWith(
        loading: loading,
        delete: delete,
        loadingnotes: loadingnotes,
        loadmore: loadmore,
      ),
    );
  }

  /// CREATE NEW NOTES
  Future<void> creatnewnote({
    required String title,
    required String note,
  }) async {
    updateloaders(loading: true);
    await Supabase.instance.client.from("notes").insert({
      "title": title.trim(),
      "note": note.trim(),
      "user_id": currentuser!.id,
    });
    updateloaders(loading: false);
  }

  /// EDIT NOTE
  Future<void> editnote({
    required String title,
    required String note,
    required int id,
  }) async {
    await Supabase.instance.client
        .from("notes")
        .update({"title": title.trim(), "note": note.trim()})
        .eq("user_id", currentuser!.id)
        .eq("id", id);
  }

  /// DELETE NOTE
  Future<void> deletenote({required int id}) async {
    updateloaders(loading: true);

    await Supabase.instance.client
        .from("notes")
        .delete()
        .eq("id", id)
        .eq("user_id", currentuser!.id);
    updateloaders(loading: false);
  }
}
