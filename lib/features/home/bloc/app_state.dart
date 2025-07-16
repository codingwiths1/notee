class AppState {
  final List<Map<String, String>> noteList;
  final bool isTrue;

  AppState({required this.noteList, required this.isTrue});

  AppState copyWith({List<Map<String, String>>? noteList, bool? isTrue}) {
    return AppState(
      noteList: noteList ?? this.noteList,
      isTrue: isTrue ?? this.isTrue,
    );
  }
}
