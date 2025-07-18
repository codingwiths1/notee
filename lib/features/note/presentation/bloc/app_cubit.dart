import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notee/features/note/presentation/bloc/app_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState(noteList: [], isTrue: false, delete: false));

  final User? currentuser = Supabase.instance.client.auth.currentUser;

  Future<void> initAuth() async {
    final Session? currentsession =
        Supabase.instance.client.auth.currentSession;

    if (currentsession == null) {
      await Supabase.instance.client.auth.signInAnonymously();
    }
    log("signInAnonymously INITIALIZED");
  }

  getData(List<Map<String, dynamic>> data) {
    emit(state.copyWith(noteList: data));
  }

  updateText({required Map<String, String> notes}) {
    emit(state.copyWith(noteList: [...state.noteList, notes]));
  }

  // editNote({
  //   required int index,
  //   required Map<String, String> updatedNotes,
  // }) async {
  //   final updatedList = List<Map<String, dynamic>>.from(state.noteList);
  //   updatedList[index] = await Supabase.instance.client
  //       .from("notes")
  //       .update(updatedNotes);
  //   emit(state.copyWith(noteList: updatedList));
  // }

  editNote({
    required int index,
    required Map<String, String> updatedNotes,
  }) async {
    final updatedList = List<Map<String, dynamic>>.from(state.noteList);

    final noteId = updatedList[index]['id'];

    await Supabase.instance.client
        .from("notes")
        .update(updatedNotes)
        .eq('id', noteId);

    updatedList[index] = updatedNotes;

    emit(state.copyWith(noteList: updatedList));
  }

  updateState({bool? isTrue, bool? delete}) {
    emit(state.copyWith(isTrue: isTrue, delete: delete));
  }

  Future<void> creatnewnote({
    required String title,
    required String note,
  }) async {
    await Supabase.instance.client.from("notes").insert({
      "title": title.trim(),
      "note": note.trim(),
      "user_id": currentuser!.id,
    });
  }

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

  Future<void> deletenote({required int id}) async {
    await Supabase.instance.client
        .from("notes")
        .delete()
        .eq("id", id)
        .eq("user_id", currentuser!.id);
  }
}
