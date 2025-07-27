import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notee/core/pagination/custom_pagination.dart';
import 'package:notee/features/note/model/note_model.dart';
import 'package:notee/features/note/view_model/note_bloc/note_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final User? currentuser = Supabase.instance.client.auth.currentUser;

class NoteCubit extends Cubit<NoteState> {
  NoteCubit()
    : super(
        NoteState(
          loadmore: false,
          pagingController: CustomPagination(
            fetchData: (offset, limit) async {
              final List<Map<String, dynamic>> response = await Supabase
                  .instance
                  .client
                  .from("notes")
                  .select()
                  .eq("user_id", currentuser!.id)
                  .order("id", ascending: true)
                  .range(offset, offset + limit - 1);
              List<Map<String, dynamic>> fetchednotes =
                  List<Map<String, dynamic>>.from(response);
              return fetchednotes
                  .map((json) => NoteModel.fromJson(json))
                  .toList();
            },
          ),
          loading: false,
          delete: false,
          loadingnotes: false,
        ),
      );

  /// AUTH USERS
  Future<void> initAuth() async {
    final Session? currentsession =
        Supabase.instance.client.auth.currentSession;

    if (currentsession == null) {
      await Supabase.instance.client.auth.signInAnonymously();
    }
    log("signInAnonymously INITIALIZED");
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
