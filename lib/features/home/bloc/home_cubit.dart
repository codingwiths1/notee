import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notee/features/home/bloc/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(titleText: "", noteText: ""));

  updateText(String? titleText, String? noteText) {
    emit(state.copyWith(titleText: titleText, noteText: noteText));
  }
}
