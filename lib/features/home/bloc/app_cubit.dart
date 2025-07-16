import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notee/features/home/bloc/app_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState(noteList: [], isTrue: false));

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

  updateState({required bool isTrue}) {
    emit(state.copyWith(isTrue: isTrue));
  }
}
