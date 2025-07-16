import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notee/features/home/bloc/app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState(noteList: [], isTrue: false));

  updateText({required Map<String, String> notes}) {
    emit(state.copyWith(noteList: [...state.noteList, notes]));
  }

  editNote({required int index, required Map<String, String> updatedNotes}) {
    final updatedList = List<Map<String, String>>.from(state.noteList);
    updatedList[index] = updatedNotes;
    emit(state.copyWith(noteList: updatedList));
  }

  updateState({required bool isTrue}) {
    emit(state.copyWith(isTrue: isTrue));
  }
}
