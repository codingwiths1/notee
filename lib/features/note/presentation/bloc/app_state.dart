class AppState {
  final List<Map<String, dynamic>> noteList;
  final bool isTrue;

  AppState({required this.noteList, required this.isTrue});

  AppState copyWith({List<Map<String, dynamic>>? noteList, bool? isTrue}) {
    return AppState(
      noteList: noteList ?? this.noteList,
      isTrue: isTrue ?? this.isTrue,
    );
  }
}
