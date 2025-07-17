class AppState {
  final List<Map<String, dynamic>> noteList;
  final bool isTrue;
  final bool delete;

  AppState({
    required this.noteList,
    required this.isTrue,
    required this.delete,
  });

  AppState copyWith({
    List<Map<String, dynamic>>? noteList,
    bool? isTrue,
    bool? delete,
  }) {
    return AppState(
      delete: delete ?? this.delete,
      noteList: noteList ?? this.noteList,
      isTrue: isTrue ?? this.isTrue,
    );
  }
}
