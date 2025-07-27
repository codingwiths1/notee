import 'package:notee/core/pagination/custom_pagination.dart';
import 'package:notee/features/note/model/note_model.dart';

class NoteState {
  final CustomPagination<NoteModel> pagingController;
  final bool loading;
  final bool delete;
  final bool loadingnotes;
  final bool loadmore;

  NoteState({
    required this.loadmore,
    required this.pagingController,
    required this.loading,
    required this.delete,
    required this.loadingnotes,
  });

  NoteState copyWith({
    CustomPagination<NoteModel>? pagingController,
    bool? loading,
    bool? delete,
    bool? loadingnotes,
    bool? loadmore,
  }) {
    return NoteState(
      loadmore: loadmore ?? this.loadmore,
      loadingnotes: loadingnotes ?? this.loadingnotes,
      delete: delete ?? this.delete,
      pagingController: pagingController ?? this.pagingController,
      loading: loading ?? this.loading,
    );
  }
}
