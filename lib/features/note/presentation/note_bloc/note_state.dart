class NoteState {
  final List<Map<String, dynamic>> notelist;
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
    List<Map<String, dynamic>>? notelist,
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
