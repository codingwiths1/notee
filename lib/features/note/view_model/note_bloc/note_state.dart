import 'package:notee/features/note/model/note_model.dart';

class NoteState {
  final List<NoteModel> notelist;
  final bool loading;
  final bool delete;
  final bool loadingnotes;
  final bool loadmore;

  NoteState({
    required this.loadmore,
    required this.notelist,
    required this.loading,
    required this.delete,
    required this.loadingnotes,
  });

  NoteState copyWith({
    List<NoteModel>? notelist,
    bool? loading,
    bool? delete,
    bool? loadingnotes,
    bool? loadmore,
  }) {
    return NoteState(
      loadmore: loadmore ?? this.loadmore,
      loadingnotes: loadingnotes ?? this.loadingnotes,
      delete: delete ?? this.delete,
      notelist: notelist ?? this.notelist,
      loading: loading ?? this.loading,
    );
  }
}
